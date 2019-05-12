# 
# /*
#  * *********** WARNING **************
#  * This file generated by ModPerl::WrapXS/0.01
#  * Any changes made here will be lost
#  * ***********************************
#  * 01: lib/ModPerl/Code.pm:716
#  * 02: lib/ModPerl/WrapXS.pm:635
#  * 03: lib/ModPerl/WrapXS.pm:1186
#  * 04: Makefile.PL:435
#  * 05: Makefile.PL:333
#  * 06: Makefile.PL:59
#  */
# 


package Apache2::Directive;

use strict;
use warnings FATAL => 'all';



use Apache2::XSLoader ();
our $VERSION = '2.000009';
Apache2::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

Apache2::Directive - Perl API for manipulating the Apache configuration tree




=head1 Synopsis

  use Apache2::Directive ();
  
  my $tree = Apache2::Directive::conftree();
  
  my $documentroot = $tree->lookup('DocumentRoot');
  
  my $vhost = $tree->lookup('VirtualHost', 'localhost:8000');
  my $servername = $vhost->{'ServerName'};
  
  use Data::Dumper;
  print Dumper $tree->as_hash;
  
  my $node = $tree;
  while ($node) {
      print $node->as_string;
  
      #do something with $node
  
      my $directive = $node->directive;
      my $args = $node->args;
      my $filename = $node->filename;
      my $line_num = $node->line_num;
  
      if (my $kid = $node->first_child) {
          $node = $kid;
      }
      elsif (my $next = $node->next) {
          $node = $next;
      }
      else {
          if (my $parent = $node->parent) {
              $node = $parent->next;
          }
          else {
              $node = undef;
          }
      }
  }





=head1 Description

C<Apache2::Directive> provides the Perl API for manipulating the Apache
configuration tree





=head1 API

C<Apache2::Directive> provides the following functions and/or methods:





=head2 C<args>

Get the arguments for the current directive:

  $args = $node->args();

=over 4

=item obj: C<$node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

=item ret: C<$args> ( string )

Arguments are separated by a whitespace in the string.

=item since: 2.0.00

=back

For example, in F<httpd.conf>:

  PerlSwitches -M/opt/lib -M/usr/local/lib -wT

And later:

  my $tree = Apache2::Directive::conftree();
  my $node = $tree->lookup('PerlSwitches');
  my $args = $node->args;

C<$args> now contains the string "-M/opt/lib -M/usr/local/lib -wT"







=head2 C<as_hash>

Get a hash representation of the configuration tree, in a format
suitable for inclusion in E<lt>PerlE<gt> sections.

   $config_hash = $conftree->as_hash();

=over 4

=item obj: C<$conftree>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

The config tree to stringify

=item ret: C<$config_hash> ( HASH reference )

=item since: 2.0.00

=back

For example: in F<httpd.conf>:

  <Location /test>
    SetHandler perl-script
    PerlHandler Test::Module
  </Location>

And later:

  my $tree = Apache2::Directive::conftree();
  my $node = $tree->lookup('Location', '/test/');
  my $hash = $node->as_hash;

C<$hash> now is:

  {
    'SetHandler'  => 'perl-script',
    'PerlHandler' => 'Test::Module',
  }







=head2 C<as_string>

Get a string representation of the configuration node, in
F<httpd.conf> format.

   $string = $node->as_string();

=over 4

=item obj: C<$node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

The config tree to stringify

=item ret: C<$string> ( string )

=item since: 2.0.00

=back

For example: in F<httpd.conf>:

  <Location /test>
    SetHandler perl-script
    PerlHandler Test::Module
  </Location>

And later:

  my $tree = Apache2::Directive::conftree();
  my $node = $tree->lookup('Location', '/test/');
  my $string = $node->as_string;

C<$string> is now:

  SetHandler perl-script
  PerlHandler Test::Module






=head2 C<conftree>

Get the root of the configuration tree:

  $conftree = Apache2::Directive::conftree();

=over 4

=item obj: C<Apache2::Directive> ( class name )

=item ret: C<$conftree>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

=item since: 2.0.00

=back







=head2 C<directive>

Get the name of the directive in C<$node>:

  $name = $node->directive();

=over 4

=item obj: C<$node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

=item ret: C<$name> ( string )

=item since: 2.0.00

=back







=head2 C<filename>

Get the F<filename> the configuration node was created from:

  $filename = $node->filename();

=over 4

=item obj: C<$node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

=item ret: C<$filename> ( string )

=item since: 2.0.00

=back

For example:

  my $tree = Apache2::Directive::conftree();
  my $node = $tree->lookup('VirtualHost', 'example.com');
  my $filename = $node->filename;

C<$filename> is now the full path to the F<httpd.conf> that
VirtualHost was defined in.

If the directive was added with 
C<L<add_config()|docs::2.0::api::Apache2::ServerUtil/C_add_config_>>,
the filename will be the path to the F<httpd.conf> that trigerred
that Perl code.






=head2 C<first_child>

Get the first child node of this directive:

  $child_node = $node->first_child;

=over 4

=item obj: C<$node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

=item ret: C<$child_node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

Returns the first child node of C<$node>, C<undef> if there is none

=item since: 2.0.00

=back








=head2 C<line_num>

Get the line number in a F<filename> this node was created at:

  $lineno = $node->line_num();

=over 4

=item obj: C<$node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

=item arg1: C<$lineno> (integer)

=item since: 2.0.00

=back








=head2 C<lookup>

Get the node(s) matching a certain value.

  $node  = $conftree->lookup($directive, $args);
  @nodes = $conftree->lookup($directive, $args);

=over 4

=item obj: C<$conftree>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

The config tree to stringify

=item arg1: C<$directive> ( string )

The name of the directive to search for

=item opt arg2: C<args> ( string )

Optional args to the directive to filter for

=item ret: C<$string> ( string / ARRAY of HASH refs )

In LIST context, it returns all matching nodes.

In SCALAR context, it returns only the first matching node.

If called with only C<$directive> value, this method returns all nodes
from that directive. For example:

  @Alias = $conftree->lookup('Alias');

returns all nodes for C<Alias> directives.

If called with an extra C<$args> argument, it returns only nodes where
both the directive and the args matched. For example:

  $VHost = $tree->lookup('VirtualHost', '_default_:8000');

=item since: 2.0.00

=back










=head2 C<next>

Get the next directive node in the tree:

  $next_node = $node->next();

=over 4

=item obj: C<$node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

=item ret: C<$next_node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

Returns the next sibling of C<$node>, C<undef> if there is none

=item since: 2.0.00

=back






=head2 C<parent>

Get the parent node of this directive:

  $parent_node = $node->parent();

=over 4

=item obj: C<$node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

=item ret: C<parent_node>
( C<L<Apache2::Directive object|docs::2.0::api::Apache2::Directive>> )

Returns the parent of C<$node>, C<undef> if this node is the root node

=item since: 2.0.00

=back







=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut


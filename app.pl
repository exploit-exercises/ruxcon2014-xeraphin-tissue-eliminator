#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
  my $self = shift;
  $self->render('index');
};

sub tissue_eliminator {
	my ($a, $operator, $b) = @_;

	my $result = 0;
	my $code = "\$result = $a $operator $b;";
	eval $code;
	if($@) {
		return "sorry, couldn't handle what you wanted :~(";
	}


	return "$result";
}

post '/perform_maths' => sub {
  my $self = shift;
  my $a = $self->param('a');
  my $op = $self->param('op');
  my $b = $self->param('b');

  my $result = tissue_eliminator($a, $op, $b);

  $self->render(text => $result);
};

app->start;
app->secrets(['6021c83b-7a79-4229-9087-fd8efd01c052']);
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Tissue Eliminator';
<form method="POST" action="/perform_maths">
  <input type="text" name="a" value="5" />
  <br/>
  <input type="radio" name="op" value="+">Plus</input>
  <br/>
  <input type="radio" name="op" value="-">Subtract</input>
  <br/>
  <input type="radio" name="op" value="/">Divide</input>
  <br/>
  <input type="radio" name="op" value="*">Multiply</input>
  <br/>
  <input type="text" name="b" value="4" />
  <input type="submit" name="submit" value="submit" />
</form>

@@ response.html.ep
% layout 'default';
% title 'Your results';

<%= results =>
  
@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>



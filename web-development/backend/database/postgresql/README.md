### select last insert id

<pre>
SELECT CURRVAL(pg_get_serial_sequence('course_promo','id'));

do $$
declare
last_insert_id integer;
begin
-- select the number of actors from the actor table
insert into haven_portal_test.public.course_promo(logo_id, content, url) values (1, 'haha', 'haha.vn') returning id into last_insert_id;
-- show the number of actors
end; $$

</pre>

### using variable

https://stackoverflow.com/questions/766657/how-do-you-use-variables-in-a-simple-postgresql-script
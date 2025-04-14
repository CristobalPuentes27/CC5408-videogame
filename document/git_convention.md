# Convención de GIT + Cheat Sheet

Porfavor usar conventional commits:

`tipo(scope opcional): mensaje corto en minúscula sin punto al final`

Ejemplos ordenados por frecuencia:

- add: added account level counter (muy frecuente)
- chore: removed unused code and comments (empate de frecuencia con fix)
- fix: unvalidated None value on User form
- docs: added documentation for User model (muy poco frecuente)
- style: changed colors of dashboard (no creo que lo lleguemos a ocupar)
- refactor: .... (no deberíamos tener que ocuparla)

Si quieren agregar el scope como _add(User): added new profile picture selector_ ta bien pero no es necesario.

## Convención y Recomendaciones

- Cada commit debe introducir cambios lo más pequeños posibles (porfavor).
- Antes de ponerse a trabajar porfavor hacer `git pull` para actualizar su copia local del repo.
- Si 2 personas están haciendo commits en una branch porfavor mantener sincronizado el repo remoto con `git push`, así evitamos conflictos.
- (OPCIONAL) Si quieren trabajar en una rama aparte mejor, despues hacen un PR y lo revisa alguien del equipo.
- Cuando están trabajando en una rama aparte y se actualiza main, hacer `git pull --rebase origin main`. Si webea hacer `git merge origin main`.
- NO hacer push antes de verificar que no se han mandado una cagada.
- Cuando se manden una cagada hacer `git reset --mode HEAD~N`. N es el numero commits que quieren devolverse y mode pueden no ponerlo, eso hace que los cambios de los commits que deshicieron se queden en su copia local, soft los guarda en la la sección de staging (como si hubiesen hecho git add .) y hard elimina los cambios de los commits que deshicieron. Ej: `git reset --soft HEAD~3` lo uso cuando me mandé un cagaso 3 commits atrás y dejo los cambios listos para commitear denuevo.
- Las tareas del backlog las podemos poner en GitHub Issues para repartirlas despues.
- Si no puedieron hacer algo, tienen dudas o problemas con sus ramas/features tambien pueden postearlo como Issue, usarlos va a servir para hacer el informe!

# Git Cheat Sheet

- Crear rama `git branch nombre`
- Cambiar de rama `git checkout nombre`
- Agregar todos los cambios a staging `git add .`
- Agregar 1 solo archivo a staging `git add archivo`
- Commitear `git commit -m "mensaje"`
- Actualizar copia local del repo `git pull`
- Actualizar GitHub con cambios locales `git push`
- Arreglar cagasos `git reset --mode HEAD~N`
- Actualizar rama con cambios de main `git pull --rebase origin main` o `git merge origin main`

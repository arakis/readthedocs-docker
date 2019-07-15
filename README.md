##### What is ReadTheDocs?
Please read check https://readthedocs.org/

##### Why this image?

readthedocs.org itself privides a build docker image, bot it's not a ready to use image for production.
I provide an image that works out of the box.
It's unmodificated as much as possible.

##### Run the docker image

```
docker run -it -v /tmp/rtd:/data  -p 8000:8000 -e RTD_PRODUCTION_DOMAIN="localhost:8000" rdt
```
You can change `RTD_PRODUCTION_DOMAIN` to another valid address.
Change `/tmp/rtd` to an valid location and ensure it's owned by `1005:205`. It will hold the database an the generated assets. You cou can skip the volume, if you wish only a temporary run.

Now visit `http://localhost:8000` in your browser.

##### Contributing

I'm happy for every kind of contributions

##### FAQ

Why no external Database or Elasticsearch?
- Because this image is build for simplicity. No Dependencies. Just a docker run.

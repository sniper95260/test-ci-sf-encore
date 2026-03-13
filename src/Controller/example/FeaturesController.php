<?php

namespace App\Controller\example;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class FeaturesController extends AbstractController
{
    #[Route('/features', name: 'app_features')]
    public function index(): Response
    {
        return $this->render('example/features.html.twig');
    }
}

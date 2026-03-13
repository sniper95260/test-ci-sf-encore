<?php

namespace App\Controller\example;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class SetupGuideController extends AbstractController
{
    #[Route('/setup-guide', name: 'app_setup_guide')]
    public function index(): Response
    {
        return $this->render('example/setup_guide.html.twig');
    }
}

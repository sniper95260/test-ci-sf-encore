<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class SetupGuideController extends AbstractController
{
    #[Route('/setup-guide', name: 'app_setup_guide')]
    public function index(): Response
    {
        return $this->render('pages/setup_guide/setup_guide.html.twig');
    }
}

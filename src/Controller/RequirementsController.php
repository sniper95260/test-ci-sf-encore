<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class RequirementsController extends AbstractController
{
    #[Route('/requirements', name: 'app_requirements')]
    public function index(): Response
    {
        return $this->render('pages/requirements/requirements.html.twig', [
            'controller_name' => 'RequirementsController',
        ]);
    }
}

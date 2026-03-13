<?php

namespace App\Controller\example;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class DocumentationController extends AbstractController
{
    #[Route('/documentation', name: 'app_documentation')]
    public function index(): Response
    {
        return $this->render('example/documentation.html.twig');
    }

    #[Route('/documentation/overview', name: 'app_documentation_overview')]
    public function overview(): Response
    {
        return $this->render('example/overview.html.twig');
    }

    #[Route('/documentation/ci-cd', name: 'app_documentation_ci_cd')]
    public function ciCd(): Response
    {
        return $this->render('example/ci_cd.html.twig');
    }

    #[Route('/documentation/project-structure', name: 'app_documentation_project_structure')]
    public function projectStructure(): Response
    {
        return $this->render('example/project_structure.html.twig');
    }

    #[Route('/documentation/customization', name: 'app_documentation_customization')]
    public function customization(): Response
    {
        return $this->render('example/customization.html.twig');
    }
}

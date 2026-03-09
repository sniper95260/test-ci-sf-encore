<?php

namespace App\Twig;

use App\Service\BuildInfoService;
use Twig\Extension\AbstractExtension;
use Twig\Extension\GlobalsInterface;

final class BuildInfoExtension extends AbstractExtension implements GlobalsInterface
{
    public function __construct(
        private readonly BuildInfoService $buildInfoService,
    ) {
    }

    public function getGlobals(): array
    {
        return [
            'build_info' => $this->buildInfoService->getBuildInfo(),
            'build_version_label' => $this->buildInfoService->getVersionLabel(),
        ];
    }
}

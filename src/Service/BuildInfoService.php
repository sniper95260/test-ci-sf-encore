<?php

namespace App\Service;

final class BuildInfoService
{
    public function __construct(private readonly string $projectDir) {}

    public function getBuildInfo(): array
    {
        $file = $this->projectDir . '/config/build-info.json';

        if(!is_file($file) || !is_readable($file)) {
            return [];
        }

        $content = file_get_contents($file);

        if($content === false) {
            return [];
        }

        $data = json_decode($content, true);

        if(!is_array($data)) {
            return [];
        }

        return [
            'version' => isset($data['version']) && is_string($data['version']) ? $data['version'] : null,
            'commit' => isset($data['commit']) && is_string($data['commit']) ? $data['commit'] : null,
            'build_number' => isset($data['build_number']) && is_string($data['build_number']) ? $data['build_number'] : null,
            'environment' => isset($data['environment']) && is_string($data['environment']) ? $data['environment'] : null,
            'build_date' => isset($data['build_date']) && is_string($data['build_date']) ? $data['build_date'] : null,
        ];
    }

    public function getVersionLabel(): ?string
    {
        $info = $this->getBuildInfo();

        $environment = $info['environment'] ?? null;
        $version = $info['version'] ?? null;
        $commit = $info['commit'] ?? null;
        $buildNumber = $info['build_number'] ?? null;

        if ($environment === 'prod') {
            return $version;
        }

        $parts = array_filter([
            $version,
            $commit,
            $buildNumber !== null ? '#' . $buildNumber : null,
        ]);

        return $parts !== [] ? implode(' • ', $parts) : null;
    }

}

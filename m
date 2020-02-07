Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7471155263
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 07:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGGSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 01:18:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48732 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgBGGSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:18:04 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id DDFEB29575C
Subject: Re: [PATCH v4 0/7] Add dts for mt8183 GPU (and misc panfrost patches)
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        ulf.hansson@linaro.org
References: <20200207052627.130118-1-drinkcat@chromium.org>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <5237381b-c232-7087-a3d6-78d6358d80bf@collabora.com>
Date:   Fri, 7 Feb 2020 07:17:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200207052627.130118-1-drinkcat@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 6:26 AM, Nicolas Boichat wrote:
> Hi!
> 
> Follow-up on the v3: https://patchwork.kernel.org/cover/11331343/.
> 
> The main purpose of this series is to upstream the dts change and the
> binding document, but I wanted to see how far I could probe the GPU, to
> check that the binding is indeed correct. The rest of the patches are
> RFC/work-in-progress, but I think some of them could already be picked up.
> 
> So this is tested on MT8183 with a chromeos-4.19 kernel, and a ton of
> backports to get the latest panfrost driver (I should probably try on
> linux-next at some point but this was the path of least resistance).
> 
> I tested it as a module as it's more challenging (originally probing would
> work built-in, on boot, but not as a module, as I didn't have the power
> domain changes, and all power domains are on by default during boot).
> 
> Probing logs looks like this, currently. They look sane.
> [  501.319728] panfrost 13040000.gpu: clock rate = 511999970
> [  501.320041] panfrost 13040000.gpu: Linked as a consumer to regulator.14
> [  501.320102] panfrost 13040000.gpu: Linked as a consumer to regulator.31
> [  501.320651] panfrost 13040000.gpu: Linked as a consumer to genpd:0:13040000.gpu
> [  501.320954] panfrost 13040000.gpu: Linked as a consumer to genpd:1:13040000.gpu
> [  501.321062] panfrost 13040000.gpu: Linked as a consumer to genpd:2:13040000.gpu
> [  501.321734] panfrost 13040000.gpu: mali-g72 id 0x6221 major 0x0 minor 0x3 status 0x0
> [  501.321741] panfrost 13040000.gpu: features: 00000000,13de77ff, issues: 00000000,00000400
> [  501.321747] panfrost 13040000.gpu: Features: L2:0x07120206 Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> [  501.321752] panfrost 13040000.gpu: shader_present=0x7 l2_present=0x1
> [  501.324951] [drm] Initialized panfrost 1.1.0 20180908 for 13040000.gpu on minor 2
> 
> Some more changes are still required to get devfreq working, and of course
> I do not have a userspace driver to test this with.

Have you tried the Panfrost tests in IGT? They are atm quite basic, but 
could be interesting to check that the different HW units are correctly 
powered on.

Regards,

Tomeu

> I believe at least patches 1, 2, and 3 can be merged. 4 and 5 are mostly
> useful in conjunction with 6 and 7 (which are not ready yet), so I'll let
> maintainers decide.
> 
> Thanks!
> 
> Nicolas Boichat (7):
>    dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
>    arm64: dts: mt8183: Add node for the Mali GPU
>    drm/panfrost: Improve error reporting in panfrost_gpu_power_on
>    drm/panfrost: Add support for multiple regulators
>    drm/panfrost: Add support for multiple power domains
>    RFC: drm/panfrost: Add mt8183-mali compatible string
>    RFC: drm/panfrost: devfreq: Add support for 2 regulators
> 
>   .../bindings/gpu/arm,mali-bifrost.yaml        |  25 ++++
>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   7 +
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 +++++++++++++++
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  17 +++
>   drivers/gpu/drm/panfrost/panfrost_device.c    | 123 +++++++++++++++---
>   drivers/gpu/drm/panfrost/panfrost_device.h    |  27 +++-
>   drivers/gpu/drm/panfrost/panfrost_drv.c       |  41 ++++--
>   drivers/gpu/drm/panfrost/panfrost_gpu.c       |  11 +-
>   8 files changed, 326 insertions(+), 30 deletions(-)
> 

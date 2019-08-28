Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A81F9FC42
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfH1HyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:54:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36114 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfH1HyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:54:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id u15so1694062ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FWSvDl8u8A9TagHUKslPXq5SjeFzZUA7+MhZLlUGBI=;
        b=SyySb40LApNqB6t9DZDy3xCJSzfkq9oiIyjKd66nYOBRQMBmp9SXVdseZyAUZNsyUr
         fM0HzG9XntwS1PBm215QTakWStTL/kE+BU5xZ8Twbx9PX9d4DvRVAVqR1p8PUJf7RbUZ
         sm0A6lKe3ISKB7iiMLcyHKxdOekG8sLYczB6S52aT4UpmSPSwqhkYThMmJC7l6Ux9H8K
         J1Ky+YnxHE5jyC4kGEaT/SjlLeE3Kzu08uPgtXN76NlB90W39WfrNCwftApX0ib5QoOW
         dhQnn+z7E12KuyGnoeOgxuvRno5NMnoUWoXBCarkNQzUkIBlrc77sY3hJjQCQdFG5jQe
         znlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FWSvDl8u8A9TagHUKslPXq5SjeFzZUA7+MhZLlUGBI=;
        b=hYahE1zYbXqIrBSjNEngFzsjUObYBvHMXHRAXiRvADz0CWdeUS6tqZnW3lQE/Kjkpl
         VCfYrObmOElp8ELGo3kV13tW8bTpYbNYtztuT5yUPmkRzVt0R75slk+KV7Goge7uNsGH
         mMUr3VMc9Rwwu2+bW4lU3o45mc5kRoThI5Eci24V5aFk2kFqe0dQEW4JNapcA/G0p/nF
         EAtugFOv1slmEnrdACBNin/OuPWbHi739hwDEoudFU0qT9SzrRag4WtWXPGFWhNV27Kd
         MaSNggTFdsCOiwPpn7rdPeRZ8ImRTueMiwWYoVAeYlRoJuRCMmEJT3e1lZ1YCObYbboR
         ht4g==
X-Gm-Message-State: APjAAAX4N+kIFMPZx2gfRk7tltzI/6KDVvnHbwCvcpPCHJJUR/anDI4u
        2YW4ZrLhxA/wytdY6R0borAHifjp3N/s4eFp/4TU7w==
X-Google-Smtp-Source: APXvYqxeb+AdkH9DgGEC/VNyhBRf9kBywzLuKN64qaPgSoo4WRvRKBmmqcBMLfUTf8k99zNgM8UjuDhaD5zGQKxwhBI=
X-Received: by 2002:a2e:a0d1:: with SMTP id f17mr1266354ljm.106.1566978840468;
 Wed, 28 Aug 2019 00:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190827161408.20082-1-ttayar@habana.ai>
In-Reply-To: <20190827161408.20082-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 28 Aug 2019 10:53:34 +0300
Message-ID: <CAFCwf13Z7W+VLiRWcFT5aVf62N1VeL4P+kbFUM-To3ZafC+RWQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Make the Coresight timestamp perpetual
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 7:14 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> The Coresight timestamp is enabled for a specific debug session using
> the HL_DEBUG_OP_TIMESTAMP opcode of the debug IOCTL.
> In order to have a perpetual timestamp that would be comparable between
> various debug sessions, this patch moves the timestamp enablement to be
> part of the HW initialization.
> The HL_DEBUG_OP_TIMESTAMP opcode turns to be deprecated and shouldn't be
> used.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/goya/goya.c           | 23 +++++++++++++++++++
>  drivers/misc/habanalabs/goya/goya_coresight.c | 17 ++------------
>  include/uapi/misc/habanalabs.h                |  2 +-
>  3 files changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index de275cb3bb98..0dd0b4429fee 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -2062,6 +2062,25 @@ static void goya_disable_msix(struct hl_device *hdev)
>         goya->hw_cap_initialized &= ~HW_CAP_MSIX;
>  }
>
> +static void goya_enable_timestamp(struct hl_device *hdev)
> +{
> +       /* Disable the timestamp counter */
> +       WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
> +
> +       /* Zero the lower/upper parts of the 64-bit counter */
> +       WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0xC, 0);
> +       WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0x8, 0);
> +
> +       /* Enable the counter */
> +       WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 1);
> +}
> +
> +static void goya_disable_timestamp(struct hl_device *hdev)
> +{
> +       /* Disable the timestamp counter */
> +       WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
> +}
> +
>  static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
>  {
>         u32 wait_timeout_ms, cpu_timeout_ms;
> @@ -2102,6 +2121,8 @@ static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
>         goya_disable_external_queues(hdev);
>         goya_disable_internal_queues(hdev);
>
> +       goya_disable_timestamp(hdev);
> +
>         if (hard_reset) {
>                 goya_disable_msix(hdev);
>                 goya_mmu_remove_device_cpu_mappings(hdev);
> @@ -2504,6 +2525,8 @@ static int goya_hw_init(struct hl_device *hdev)
>
>         goya_init_tpc_qmans(hdev);
>
> +       goya_enable_timestamp(hdev);
> +
>         /* MSI-X must be enabled before CPU queues are initialized */
>         rc = goya_enable_msix(hdev);
>         if (rc)
> diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
> index 3d77b1c20336..b4d406af1bed 100644
> --- a/drivers/misc/habanalabs/goya/goya_coresight.c
> +++ b/drivers/misc/habanalabs/goya/goya_coresight.c
> @@ -636,24 +636,11 @@ static int goya_config_spmu(struct hl_device *hdev,
>         return 0;
>  }
>
> -static int goya_config_timestamp(struct hl_device *hdev,
> -               struct hl_debug_params *params)
> -{
> -       WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
> -       if (params->enable) {
> -               WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0xC, 0);
> -               WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE + 0x8, 0);
> -               WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 1);
> -       }
> -
> -       return 0;
> -}
> -
>  int goya_debug_coresight(struct hl_device *hdev, void *data)
>  {
>         struct hl_debug_params *params = data;
>         u32 val;
> -       int rc;
> +       int rc = 0;
>
>         switch (params->op) {
>         case HL_DEBUG_OP_STM:
> @@ -675,7 +662,7 @@ int goya_debug_coresight(struct hl_device *hdev, void *data)
>                 rc = goya_config_spmu(hdev, params);
>                 break;
>         case HL_DEBUG_OP_TIMESTAMP:
> -               rc = goya_config_timestamp(hdev, params);
> +               /* Do nothing as this opcode is deprecated */
>                 break;
>
>         default:
> diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
> index 6cf50177cd21..266bf85056d4 100644
> --- a/include/uapi/misc/habanalabs.h
> +++ b/include/uapi/misc/habanalabs.h
> @@ -451,7 +451,7 @@ struct hl_debug_params_spmu {
>  #define HL_DEBUG_OP_BMON       4
>  /* Opcode for SPMU component */
>  #define HL_DEBUG_OP_SPMU       5
> -/* Opcode for timestamp */
> +/* Opcode for timestamp (deprecated) */
>  #define HL_DEBUG_OP_TIMESTAMP  6
>  /* Opcode for setting the device into or out of debug mode. The enable
>   * variable should be 1 for enabling debug mode and 0 for disabling it
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next
Oded

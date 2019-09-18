Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F185B5FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 11:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfIRJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 05:07:28 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45220 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIRJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:07:28 -0400
Received: by mail-lj1-f169.google.com with SMTP id q64so6383595ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BXE/TWSYzob8gU+Sikgl7OYHXmDtFDDYWo25UJgLagE=;
        b=pew8Ehz/lTQqKN3suMmYGdevEHP6yS/gJ7V7z8F/VolEsaRy4sDN0lTAEdFh/AZ7iw
         /+gXCLLgLVszHjHDkQ9xqfWBBknsiUxXE7hBsyg4p+YuOjZueNbCfGRDFs1nePuY9Va8
         4uZpqfaM9h72sMrRbs7MGXVdJuYp+bRTExcvnIlKj4wzs27RAS5YwUqTySyMWqMyuEFT
         9uSn6whYDNrdY4O6+9gUQXTNIJQkhQhJo1QmmB1qAYswkta7E12i4iBEY0DLeOUUfBmr
         OLJvXLDKAYYkYeUfaoru02Cily/DLzlPZplYFg+1XSNBC98OwUtZCPcBe7dd1/woV+mr
         4sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BXE/TWSYzob8gU+Sikgl7OYHXmDtFDDYWo25UJgLagE=;
        b=hPD8SLFwFHuX0tUfzZE0riP9Tv7LzkvZSm4SZJDt+edt8LVU+DIJ9zGVK4I1W1FeAR
         qLLqAffkv1H3MCGPDsIA33DJXIKMOk/gBbOo/wrk5z0Uy08vTlnSVXp6cX9yKFOggmQR
         sYtmEsr5S3Ys5rhvasbNBif6LLd8ffSkhExkAlp8vLYq3aZgRYsqJ0+vNLKJXWL9Oyn5
         mYSSi21I/G0UsO0K35N69phtANUdlF/hm3KWVg3kucbcTcATrSRGjlcGPUGjSTeicx0h
         v/MFajvFVZKNxE7kuVUiuzStPtlXN2ppnbvlVmKLAIxvFA37/itdpNGglxWGCSS/kbax
         pEdw==
X-Gm-Message-State: APjAAAUg6BxY8SpJFnh8Dv2HaizcdVNqJytChVnQMTRHMQLDakHUEwb1
        AHaIt6qrbpj2l919NhQygUNsdT0jU/DumZqJ0ybF0CZd/DM=
X-Google-Smtp-Source: APXvYqwvZ2cnmrxKceb3DfYbGAsM3pbesQZixOTRkNY+AgNex2VnvWeGwucYFcguE8Ij0Cgxm8DV2F8UKoISpL/vmSo=
X-Received: by 2002:a2e:5418:: with SMTP id i24mr1570575ljb.126.1568797645638;
 Wed, 18 Sep 2019 02:07:25 -0700 (PDT)
MIME-Version: 1.0
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Wed, 18 Sep 2019 12:08:02 +0300
Message-ID: <CALN7hCKMP7xr4KmnP=hzC8rsBNk5vgmvybTy+ViUw9=2A5_NBg@mail.gmail.com>
Subject: About getrandom(2) contract
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Unlike other syscalls(like `read(2)`) `getrandom(2)`'s contract
doesn't define what happens if you pass `buflen=0`, does the pointer
still has to be valid? (what does valid even mean?) are there any side
effects?
i.e. is `getrandom(0x01, 0, 0)` undefined behavior?.

Thanks,
Elichai.
-- 
PGP: 5607C93B5F86650C

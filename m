Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92EB5408
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfIQRWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:22:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44542 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfIQRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:22:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id k24so981880pll.11;
        Tue, 17 Sep 2019 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=3jwMWA6cEaxv9WIpjetOwYYBqadUeJXhUuLUJM/0FHI=;
        b=gN7Bf0zDEeQB9AtiCpbYNI6a0kYmT1TLFzKVBdvqKMHXuhy+sUkc0t14PlE5PZG5TI
         909fvmF0W0i6l33AcNKC2HC5jVVQYRWuVjyfkGiT8bdAw6Q0w2AQuvfQTmJ2YnnIVvnM
         O1AMqy+MZiI4fwk/ALRM/9+P3Z0xalM0gA0cOBwDqHaYqwf8Eg65ZbaACpPFOea+TNDN
         wlULQEw7c4a8T5BgfHa9/YC3+ftyVbS8B1Pl3tBpPZ5KzudZAVT2jL4PtDtfagvX0CrO
         s0oNrtarWKVA9VIr61nSto+VjLNgGSP4WlbCZnigXqTiGvs1UuQRjGH+HzKdt0jPDcCc
         0Aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=3jwMWA6cEaxv9WIpjetOwYYBqadUeJXhUuLUJM/0FHI=;
        b=CAciPGOQUFOQRCN3OP5wXvyuyOM+NoLDdnsR0ZFYOWYDp+H56HqU27uWsnb2RIM2FE
         vgI8PY3DDp36mbp+0EJQUcS+0v9UQc9XVl4p5bXJyiBcV/dvdndu4Z6Zts40yJsUjmfe
         9chL+caZhuX9vQiIhxpQ+sTFEnYfcHJT8BmuTNcttVDjYhqfoc8t6tlUh7R3YVwe1ZfY
         NtYMBIYy9YEMg7WXPhKr82FXTsnaKwmeTUOEVClR93XkKuB8ZATlCrE3jHKuBmU/drME
         y4N5hgbz74Xo/N0owyQUTsrKfMDoqIvWyPfLJwO706HdA22pqqHREI/V4PfBGVAsDcKT
         yHmg==
X-Gm-Message-State: APjAAAUsOBthc0UswvfQUoBOGtQTSvckaQlt6X/onIzLSBTniSs/GQTd
        ziEAXLRvuNU6VyvRVoYW6rI=
X-Google-Smtp-Source: APXvYqxhCVkyATlZAfZye8nSnYnaGdsS+VtADLd9a4rTVNBS9yExFmRhXXgjTinxQ7i6hLDaB3sqIw==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr1463796plo.103.1568740962871;
        Tue, 17 Sep 2019 10:22:42 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z3sm3253427pjd.25.2019.09.17.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 10:22:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: dts: Fix gpio to pinmux mapping
Date:   Tue, 17 Sep 2019 10:22:41 -0700
Message-Id: <20190917172241.31726-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1568018127-26730-1-git-send-email-rayagonda.kokatanur@broadcom.com>
References: <1568018127-26730-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Sep 2019 14:05:27 +0530, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com> wrote:
> There are total of 151 non-secure gpio (0-150) and four
> pins of pinmux (91, 92, 93 and 94) are not mapped to any
> gpio pin, hence update same in DT.
> 
> Fixes: 8aa428cc1e2e ("arm64: dts: Add pinctrl DT nodes for Stingray SOC")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---

Applied to devicetree-arm64/fixes, thanks!
--
Florian

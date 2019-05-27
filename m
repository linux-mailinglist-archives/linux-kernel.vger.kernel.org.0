Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A792B9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfE0STp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 14:19:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33543 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfE0STp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:19:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id q186so12467235oia.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REA5zbty0xHe7KtmiN42aAu+VNT3yUAx9IRSmGEhNfk=;
        b=gbV3rcSaNWdBb7ut8i8munG9MXAOo1fy/pLLtM3+3QVqU5C1gi2Z1GBTBAgzs8hgPf
         8cptcKIa9Io9RbzWpXy5PMaVA7P8xJwtzv4ARVL/60OtrdBRKOglUTb3ZgcbrCY0NH/1
         6zDVtmlqq6MRXVJvYKO57yaEGQThkUOsq7us9n35ODeZFrsL147+GXbEO2qZMCvp1fDu
         3EcCdn997nuGb+LJbAaHSESI41byavV3pUN5qol4IX9CQ4H5Xk0D2w957Qu6Ssl7yhHR
         EYw5ll+x1heXuUotikVRRDhJ5Mntrh73wusDulQvKzIeer0WrL6mBbR19gbHS6giiYwf
         wASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REA5zbty0xHe7KtmiN42aAu+VNT3yUAx9IRSmGEhNfk=;
        b=m+i9XiWeQbzRiQPSa3SWtKCCDEvZ/AqZ0NIrKCqmBV5YJ7zkstLnwyZgO3el9yJu7j
         aEslBoiXByOco39Id8cOeBc6zMTENZ7obUFPNCHVFStJnJLe+Bwd9nZy/CKdfRh64qJn
         Nq+gOMPPIhO+ZPMJs7YRV1lNZGhIndI9Nfx9eNmITqFlxiKvZ3cJaNK0RscMTjb8n15v
         wh96qvDfHEOlcNdtxepnv2/q8jVrzdAeb0H9HaNS+0PcSuo3eQYbTUuStI81b3UHd13G
         BLrqeOmYzBkiB5dC4Ckl8hOLbkGlKHn5VXZMga0/3YMxfdwaQlql8sg772S2+YF0RdCk
         Rh/Q==
X-Gm-Message-State: APjAAAV2c5ncrm4bEID7deU27rdxRL4Zl/4WvtawSHD4DnlT3YFG6k51
        n/9IdRqW7CJvUUlzOHiA1UwmAt8PUfcI7N4pqmNedW/82JQ=
X-Google-Smtp-Source: APXvYqzTi4qquj7OmlvYOg2myEZ6aId7IpEInhvdySDJtzKXSiQr5zVib3yXSGtTUawov380F+pHCxVj892XOBAGFtY=
X-Received: by 2002:aca:3545:: with SMTP id c66mr167035oia.129.1558981184670;
 Mon, 27 May 2019 11:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-5-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:19:33 +0200
Message-ID: <CAFBinCDRASWwVoh=vuyqyn5HTHcfa9cXXnMWfpHSbxUAeTAFgg@mail.gmail.com>
Subject: Re: [PATCH 04/10] arm64: dts: meson-gxbb-wetek: enable bluetooth
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> This enables Bluetooth support for the following models:
>
> AP6335 in the WeTek Hub rev1 - BCM4335C0.hcd
> AP6255 in the WeTek Hub rev2 - BCM4345C0.hcd
> AP6330 in the WeTek Play 2 - BCM4330B1.hcd
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I don't have any of these boards nor the schematics but the
shutdown-gpio matches with the reference board Bluetooth GPIO and the
rest looks fine, so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

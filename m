Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA95193D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 12:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgCZLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 07:01:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41559 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgCZLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:01:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id z23so4425496lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdGN3xaLWLh2g9ItHfw0n6XCBLId+VTX6q4Rvqq4Sjk=;
        b=Hno7tLQKINqDFQBKig6K/4mPno/jREl+dokP2yCVBvAEiJHXxSOaziAirLO3YLxDGx
         ZwlByCcWt6aUrqPFwjzYbiq7GeVcUS+Us7HOXnvwSqzIenXVhw8Kef1eZEfJu/WG5IUp
         RO2BgAdyQvvhpoTdTXMmbhQ7DjEuUEifYDigfsRht0Pop91Xk2wmZVU39hD4NQdLs0u0
         cyBjrD6Oj0bhkkUUtKvFuLutMJO7iZm9vHQoiMRq+sMGoD3i4Fl4YfGPaCoNrGoFkUGP
         uHcKj7BniGoR5cg/CwXxR1auAEEiboE3X4/yj6mccmXVYYfd6iXKNKerEzU24JwVUxSc
         1zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdGN3xaLWLh2g9ItHfw0n6XCBLId+VTX6q4Rvqq4Sjk=;
        b=inf8qC2ergLPGwRGnb5XzC4xHaaujEA/5ZDhvL4UyCDeMEocvnbEITrPK+jjMi1P9f
         jGSINLtHrK8QZzlAoJFiVZWaED+Ig2gB8KM7a2J7YbUdvApodbosLqbsgPfs7jXmxLC/
         JRhNKyFWwuVDBiy7bMf5jb+q/w/caxV5qPrRCsZpUIWxRx0T7si3/7FbKJaYSu+A2YgS
         TLtqsfnn2aKcIpt4o0EV1mWl4WtfTcqQ2OPDMVSRTPb9an0DL6fmLAJ0yEj7NzPEuZ+e
         9LO85nTfjVi3pu58cvDo+ud3DbERAWKsO5bmb5FhuVUqJoV/nSSPaNz4Ladlpb/OY80a
         ha0A==
X-Gm-Message-State: ANhLgQ2RiOYQIbSUmK/tTY+SFhKMiiOiqeDRV3YOcfQLSbafWe26R5Fv
        b8KD+Bgx0JrrYRThMxZhYcqOhCMTredGwNsYy/LGog==
X-Google-Smtp-Source: ADFU+vu+++HmXhz0sLdZAQQoGQMXgK6tL/nvZrwEdCr/OwTj8sJydRwxvOW31v4mvR9kJ7wmEE83hCMNyIbdzIClDWk=
X-Received: by 2002:ac2:5f7c:: with SMTP id c28mr5067560lfc.4.1585220499722;
 Thu, 26 Mar 2020 04:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200325113407.26996-1-ulf.hansson@linaro.org> <20200325113407.26996-2-ulf.hansson@linaro.org>
In-Reply-To: <20200325113407.26996-2-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Mar 2020 12:01:28 +0100
Message-ID: <CACRpkdbFQ4kjgxxwrTjXZWAt38AM2kyMbeaCX6wjMgyyRmE55Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: platform: Initialize dma_parms for
 platform devices
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:34 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> It's currently the platform driver's responsibility to initialize the
> pointer, dma_parms, for its corresponding struct device. The benefit with
> this approach allows us to avoid the initialization and to not waste memory
> for the struct device_dma_parameters, as this can be decided on a case by
> case basis.
>
> However, it has turned out that this approach is not very practical.  Not
> only does it lead to open coding, but also to real errors. In principle
> callers of dma_set_max_seg_size() doesn't check the error code, but just
> assumes it succeeds.
>
> For these reasons, let's do the initialization from the common platform bus
> at the device registration point. This also follows the way the PCI devices
> are being managed, see pci_device_add().
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This seems in line with what Christoph said.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I imagine we can eventually set up more of the DMA config such
as segment size based on config from the device tree, but I'm not
sure about that yet.

Yours,
Linus Walleij

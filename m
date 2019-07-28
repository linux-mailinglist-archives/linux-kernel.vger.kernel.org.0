Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8B77FA4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 15:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfG1Nkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 09:40:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40866 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1Nkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:40:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so57033023eds.7;
        Sun, 28 Jul 2019 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/N4pBS+wzG7+cVkEEmHSw6pNTtAYb7dDfOSm3I7p1oM=;
        b=qSckxRVkUtkrI3T63z01gTkOz1QXroD736U0Lu0+7KoWAl2iJMO9Qp29pATJ7/e2Bj
         1UffHHo/J8QJaKujQ6rDOlgKsfeIbLilO2+thQShb3Yolf8+xHnAp8F/V97tKvL7BCm0
         tnSPXAG6zoAiMaFeJaFZtlBl5++4/WQF/TkSoV9ov8aVWLjR2cM6MndqCqZCQIYlra8u
         4kswHPvcZRUyCx7JgkawhgHr6QDMgE4NA9r9j70cR7BIgGseXfl37qxKUTk5MRgPP84U
         4gQDgNDJun5NSKvSInJh+8IztC+VmHfT2mMdvJXewdbsH91WslW8BrlVRhyX13NYDgF7
         OROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/N4pBS+wzG7+cVkEEmHSw6pNTtAYb7dDfOSm3I7p1oM=;
        b=QNsq6FHSkdQCgyann4n51B+d3kjOcEWRFRJA2jlImTAS/gNA8x6TxMhSahf2nv84QB
         VWHkfgLqDMIT1hRTPoDp6Z3sZh+iiHrwFyZ/C5MlcVVA8sqG2sPv/ghHTQ6qf3PxaM80
         CefBON4RuRevLcEvWl8ovoFXUM/ylLrW+B+kFvijvH91GPoPhAua4o+QofUKxqJLjrKH
         QZOG3F+y+Z65mKivpI6vsJ/a/J+foqf8XlO5m5VnQKvOLATNIOegB0u7ic2Z2G4NCAm3
         BLPFxGjeHOPxLdHMdqKNJlvTPo5qN1u4sRLfvPNGZ6r9Npm4x8ygYGQ9vAyQ1kGstpFR
         4WCg==
X-Gm-Message-State: APjAAAUeOHG5SI5lHdp/Iv4++C9OWpYNBqNtnChgrtCScCvebbEDvQlq
        kpTci4iFMZBp/AALANSlfLqjdTVl/Nbqckrt8PRbZZc1
X-Google-Smtp-Source: APXvYqxrdx60nP74vKeV9PJU/NlokFcEKb4pT2kFy7UFBCuBn92G77ltXyW197yRIj65YGGATN7XscVngZvnAYQGATg=
X-Received: by 2002:a17:906:a481:: with SMTP id m1mr56063760ejz.87.1564321240719;
 Sun, 28 Jul 2019 06:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1907251429420.32766@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907251429420.32766@viisi.sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 28 Jul 2019 21:40:29 +0800
Message-ID: <CAEUhbmVHjy86js51u-VP=X8h4xg19kBjKkGRu+C2T2pUwQz6Qw@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: fu540-c000: drop "timebase-frequency"
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 5:31 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> On FU540-based systems, the "timebase-frequency" (RTCCLK) is sourced
> from an external crystal located on the PCB.  Thus the
> timebase-frequency DT property should be defined by the board that
> uses the SoC, not the SoC itself.  Drop the superfluous
> timebase-frequency property from the SoC DT data.  (It's already
> present in the board DT data.)
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

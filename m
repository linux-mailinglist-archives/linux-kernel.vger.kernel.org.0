Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A454ED90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 19:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFURGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 13:06:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41452 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFURGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:06:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id s21so6605721lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYRX0+hETX8ncJ2+pB80INUIG2Op14XGJcOM1tOsCBU=;
        b=RPOmrzbYIkxhHBNXP6hYEbvyMQml0Y3hh4xmc8G7oTAv5T1DIzP/7cPFLOvh9lMyv5
         x/RQY5nguAoz824A6EmRb3LkiiqK2EzUS/Vy6jkDD0RCnxXaFP0Qca1lM5eV9k41Fh7p
         I3STnOs7Zz2zCgu304OEn03qpSF3ZMORLLHY/1biWZ35MUHK0vaVebOv9sqXBjg+1Key
         FDT4tSMLVxknKnvq9DkyJP8OnBREdyGYw9n8UCA0SJwVwcp+0u1hmIOsmJ8cSPgjPDAk
         aNwk0arivdbfRGgxeCsvMqvT+0KKfK68fF1PVNI1rAnNaR2EfTv333CiyFWR6VXQQKPu
         WSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYRX0+hETX8ncJ2+pB80INUIG2Op14XGJcOM1tOsCBU=;
        b=N2VlseseM3s+QjQDc0XmqfZdrXAN92rGtN9CMbP78+17ci0S9OKfPcmZ5pvreK9LMX
         Tf5x11mxlSeFhBvptc8dxgOCbEKLTRjzSoj9fGgrIgw7pvec8/mell9R1poEHgvLu8QL
         NB9abq0pHIyzFcwHHWRqmlQzoWUnmGEZAtoZvvezzema4e8/ZnZqu6496ADfmcYzLsVW
         EnyHN/S/o+jQx/6FmaYlwPLJ+gyD/nWYxAFt2FbICYMgaZ/wh+CtTi+oM260rx8z6sJH
         j25tkxG9y4Kys4eqWJYgVW7nt1Z3oaeMCMAHcWqyAgqZCuxilFlD2Gb+gRMt0sa/9SXT
         pBRQ==
X-Gm-Message-State: APjAAAVXhCtPOTYyo2nbTcRqk3QNuqUDv2VhH1kYDaQtqslu4luHw6H0
        QhGSEdRIDLKT9BdAPiiLeN25V/SNj1PbI32PVA66oGpb
X-Google-Smtp-Source: APXvYqzMzl+aXLfwSw8Fl2npMtKUHjd+jXSZkKwopZdBhUWEFJP4bR5enT/w3S8BaoiPjdhr36aETqfSBNuNK4ATrnw=
X-Received: by 2002:a2e:9155:: with SMTP id q21mr42291452ljg.198.1561136777139;
 Fri, 21 Jun 2019 10:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyM7BRfAwruJ4QsY_gMCGVHxS=ag7cNA1H304zcnAFK+A@mail.gmail.com>
 <CAHk-=wifNAnkd+bXfoNWXO1K5NQ8Tr+Hc13SgaBXU3RoQB7Pwg@mail.gmail.com>
In-Reply-To: <CAHk-=wifNAnkd+bXfoNWXO1K5NQ8Tr+Hc13SgaBXU3RoQB7Pwg@mail.gmail.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 21 Jun 2019 18:05:16 +0100
Message-ID: <CAPj87rP451duPWi4TQjcqzbyVKYp_v7=ibwR=2UnQyWttLDWNg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.2-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Jun 2019 at 17:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jun 20, 2019 at 9:21 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Just catching up on the week since back from holidays, everything
> > seems quite sane.
>
> .. well, except for anongit.freedesktop.org itself, which seems very
> sick indeed.
>
> Does it work for you? I'm getting a connection reset, no data.

It is quite sick indeed; it's fallen down an NFS hole and is being
restarted. Should be back in a few minutes.

Cheers,
Daniel

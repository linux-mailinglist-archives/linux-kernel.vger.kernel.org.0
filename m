Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3762C4B622
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 12:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfFSKYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 06:24:11 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33382 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbfFSKYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:24:10 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x5JANtFk032747;
        Wed, 19 Jun 2019 19:23:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x5JANtFk032747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560939836;
        bh=0XRNDHTqAQT1hUqymmlOEoJ/6E/gxdmb1Yo820b2D1c=;
        h=From:Date:Subject:To:Cc:From;
        b=iKrfmQRkXFsCBhVT7aLcu545FAANheR7NVsDHvrToa4/gIlzrB/AxMk0bQ5xNpEW7
         +tbSTQCKmdpgjNRWRR6idFSxPMIEHSyhU+asfGAEg5NPvAhaFh2BjaCHcgoJc3DaVz
         O1maM5Swk7ioTIuBEc6ELxRSCiw59Yj6Lb8mF5M24Jo6xw9c/Xh3qimc7GLmsM4wlM
         wz77N3FU7jIXphHlsW8qj+TQviP9A7cZBk2bFncLgENqGFiwqNocOPR2UVf1opREOM
         MztsVyCA0965BAvS5VonpOOQqaaG4irFjObvyl2TdEaU8WTQjzq1tr3lXPVGRu8cOl
         KtDu7Vtt19a8g==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id o2so9210327uae.10;
        Wed, 19 Jun 2019 03:23:56 -0700 (PDT)
X-Gm-Message-State: APjAAAXNdk1z/eUmvIkjykZ7jyGfGWfHcMKKvrV+54nk/oogkAZBYsQG
        gis4iaJ3plKBi7u10saDpGlpWMNrm23Qt9K+X/4=
X-Google-Smtp-Source: APXvYqyInKJ/YYVd0gUjVQhiAeBUZKyXxFak9WKWiadFa7tTSXAKGkQW32+EAKZPwBu9Nxen/BXsPjMy7COsS/6hWTw=
X-Received: by 2002:a67:ed04:: with SMTP id l4mr48617491vsp.179.1560939834877;
 Wed, 19 Jun 2019 03:23:54 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Jun 2019 19:23:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNARHHXv5Tu4BHN1avKOExS6HmPfd2c0ELZiQaxtmETOsDw@mail.gmail.com>
Message-ID: <CAK7LNARHHXv5Tu4BHN1avKOExS6HmPfd2c0ELZiQaxtmETOsDw@mail.gmail.com>
Subject: SPDX conversion under scripts/dtc/ of Linux Kernel
To:     David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh+dt@kernel.org>, linux-spdx@vger.kernel.org,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In this development cycle of Linux kernel,
lots of files were converted to use SPDX
instead of the license boilerplate.

However.

Some files were imported from a different project,
and are periodically synchronized with the upstream.
Have we discussed what to do about this case?


For example, scripts/dtc/ is the case.

The files in scripts/dtc/ are synced with the upstream
device tree compiler.

Rob Herring periodically runs scripts/dtc/update-dtc-source.sh
to import outcome from the upstream.


The upstream DTC has not adopted SPDX yet.

Some files in Linux (e.g. scripts/dtc/dtc.c)
have been converted to SPDX.

So, they are out of sync now.

The license boilerplate will come back
when Rob runs scripts/dtc/update-dtc-source.sh
next time.

What shall we do?

[1] Convert upstream DTC to SPDX

This will be a happy solution if it is acceptable in DTC.
Since we cannot push the decision of the kernel to a different
project, this is totally up to David Gibson.

[2] Change scripts/dtc/update-dtc-source.sh to
    take care of the license block somehow

[3] Go back to license boilerplate, and keep the files
    synced with the upstream
    (and scripts/dtc/ should be excluded from the
     SPDX conversion tool.)

Or, what else?

-- 
Best Regards
Masahiro Yamada

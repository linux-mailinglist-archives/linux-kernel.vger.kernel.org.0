Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84C019B6EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 22:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbgDAU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 16:27:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39161 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgDAU1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:27:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id a43so1477744edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ox3otBw8CzCvAty3EpckqUjW2/oZzIrj4z0gJgITkh8=;
        b=sQuNaukoLTYPKuSCOZWDal0NVhFHo2FQ1CmrMenvvhrri0xPkNrgQjkJcS1+O304jX
         G1LL/dvPZIIr5S9WQMK/YzWuBdT05hnu8M2sVpzIve49oA8uvXfH3d99ZokG/NhXws72
         wmFZ2tu2j2+0e7hD39WL0MxFiP1l0JGtXpUDxN8szy2nhjCLK2S7TgZrjq4FfFPh1Yvx
         +MdXV7ahHwxBQTe7fjTbXXXHhUTv0/xGRNa8wzR7wn7HAVNFCmWFhr2x85j8eb8qnyz6
         WXKxqKPC0Ebv8XtBB+cwMF+QyoYWOsaxqiAQsei59ulMxlQvzjoT+Riz/P477b/2B2k7
         YmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ox3otBw8CzCvAty3EpckqUjW2/oZzIrj4z0gJgITkh8=;
        b=qCVGcxE087mY6j8JL+ycwq/WOQ85p0uF/+O6vVFpBGvY8cSdFL0ZGxcgVPJRY5d0aD
         nJV6l3zOFyiItpmNyuFTn+uqPCBidNEjtdbWC+y3fWaazkT3lH1bxdbPHrJ6Rs5WhXbO
         TZd2PiSjLUaNNX8QqcloUrZGWrPQrbzs34BC3NoCbKtTVhERO+/658nSODZyqvZY9wYW
         bRTddGBhXtlM41i2c6qj45SC5d8I1O6FnwwVj40XEJqnSHQfyxY9xik5U6F7BEE2d+Gu
         XFkH8N8LSpUEmp4QYKU9j7u8UA7QgXfd1+2RKMT6tGmfEBcO1F1wiQOpPCYflLGigCHa
         PwKQ==
X-Gm-Message-State: ANhLgQ3kvYRvSQsZ8OU7hn7LvisZy977YX6NIPLN5FWmUJI7vGGlHiYL
        Jdn1JQnPuPPDK2LVA1IZR0GEBUf1I1pEmqvsCWzXkg==
X-Google-Smtp-Source: ADFU+vuuCiWk8AFivXDQPqBgDNLDGhDO6sjqg2/h0Q5ehu4Z/Qb1gPEAD/3R4NV/CE3+xOjAXK/2PN8nmS9Qu76SchY=
X-Received: by 2002:a17:906:dbd4:: with SMTP id yc20mr21851655ejb.335.1585772854886;
 Wed, 01 Apr 2020 13:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-13-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-13-alastair@d-silva.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Apr 2020 13:27:22 -0700
Message-ID: <CAPcyv4hBSa_62siaaOR+PG7cEohTp-xnxZ576aJO0BDofJEN=A@mail.gmail.com>
Subject: Re: [PATCH v4 12/25] nvdimm/ocxl: Add register addresses & status
 values to the header
To:     "Alastair D'Silva" <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:53 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> These values have been taken from the device specifications.

Link to specification?

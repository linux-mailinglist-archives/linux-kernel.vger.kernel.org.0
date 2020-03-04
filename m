Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59F31797CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 19:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbgCDSZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 13:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgCDSZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:25:41 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC822166E;
        Wed,  4 Mar 2020 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583346340;
        bh=YbxSKTj+LYP9ob1/gIRYSwkiErAazg4kjCl0Ex3B0LE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PVZv48kmmWr7ZkljfCQwnXQ0tlHKmi6HnRX122KFBjjZ+IyRyTU7qhRvV26Dvk/pM
         KkmsYWYbI+6uPUKxyj9Ax1OtdLu3inphUPfSvxloMv/ywt2kqjno13Db+PkqWdOeo8
         ITN70bObTvRwqI/1hAc8kPZBXCitxnt8mcOUzXAA=
Received: by mail-qt1-f179.google.com with SMTP id r6so2102567qtt.9;
        Wed, 04 Mar 2020 10:25:40 -0800 (PST)
X-Gm-Message-State: ANhLgQ2JS2x4nRwupxhBMgDlkpesDTF1GgPMA77BzDi9ZP3cnRwfXRcX
        7vn2F21EYwDQMfqo3sDlOSnn7ED4n0t+jMrOkw==
X-Google-Smtp-Source: ADFU+vvSKC5FiWZMLwOH/etNBdGnVzaAeXHbZ2Rkz1S9aEp4YeqS83ONsARP9M3LH/0+8SclIoKFCdXkwGzuX7Q/W90=
X-Received: by 2002:ac8:124d:: with SMTP id g13mr3696997qtj.224.1583346339495;
 Wed, 04 Mar 2020 10:25:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583135507.git.mchehab+huawei@kernel.org> <b7c582284fbca91a7431ff14689ab1be2c6fc410.1583135507.git.mchehab+huawei@kernel.org>
In-Reply-To: <b7c582284fbca91a7431ff14689ab1be2c6fc410.1583135507.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Mar 2020 12:25:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+qEA16aGAaVnwX6QAPGnCWqnx_6WNuRb0erVAA3rvYSA@mail.gmail.com>
Message-ID: <CAL_Jsq+qEA16aGAaVnwX6QAPGnCWqnx_6WNuRb0erVAA3rvYSA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] docs: dt: convert booting-without-of.txt to ReST format
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 1:59 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> - Add a SPDX header;
> - Use copyright symbol;
> - Adjust document title;
> - Adjust document and section titles;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add table markups;
> - Add it to devicetree/index.rst.

Let's skip this doc. It's been on my todo to remove it. It's pretty
stale and 15 years old. Much of this document is now covered by what's
in the DT spec. There's a few pieces that aren't which we need to find
new homes for.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/arm/booting.rst                 |   2 +-
>  ...-without-of.txt => booting-without-of.rst} | 299 ++++++++++--------
>  Documentation/devicetree/index.rst            |   1 +
>  Documentation/translations/zh_CN/arm/Booting  |   2 +-
>  4 files changed, 169 insertions(+), 135 deletions(-)
>  rename Documentation/devicetree/{booting-without-of.txt => booting-without-of.rst} (90%)

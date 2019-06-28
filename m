Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0775A715
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 00:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfF1Wii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 18:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfF1Wih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:38:37 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F552133F;
        Fri, 28 Jun 2019 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561761516;
        bh=Qt+cAJ52GLA63QrWkzGeZKJsplJqNIMSYE5GBj8JhjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hwvnMORs4uOEwjJTG7YFBtZ6PZ8yRTNAk1eKjHk07NdR+WlDVKt1uLV4TEjQHvIZd
         ZYKCT5RyfEJd7DuvxH1sl2LLnds5xZoiV/vqu+MYVsNTcyC902Jxi6imHVbQijRle3
         40IMXTIB7De6SBWVFM8jRlNg+uHN0MYUe6jNX+tE=
Received: by mail-qk1-f175.google.com with SMTP id c11so6252802qkk.8;
        Fri, 28 Jun 2019 15:38:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWcgPsDkF/TwPScgXVvXdWMyzXmk1OP4K2vcxl/nCmS4Il6GY8Q
        zoW+hEYiMSms4dLPd2JvrigQaPPAqWu/aofjCA==
X-Google-Smtp-Source: APXvYqzG64sLlHwqWAsoPomezD/wckflcqxY2q/xB9lqiMgpJwuMVQ9hPVS7I7cHgiIzTc8vKOV6P99fvkT/jYMwmUk=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr11072556qkl.254.1561761515855;
 Fri, 28 Jun 2019 15:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561756511.git.mchehab+samsung@kernel.org> <7a5734d147788ffb817c8122dbb0ff619a718a71.1561756511.git.mchehab+samsung@kernel.org>
In-Reply-To: <7a5734d147788ffb817c8122dbb0ff619a718a71.1561756511.git.mchehab+samsung@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Jun 2019 16:38:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNUNbNbB085y6O1ZYpS6pKSOS+3YNWZ-au0O7SN0Uu1w@mail.gmail.com>
Message-ID: <CAL_JsqJNUNbNbB085y6O1ZYpS6pKSOS+3YNWZ-au0O7SN0Uu1w@mail.gmail.com>
Subject: Re: [PATCH 1/5] docs: convert markdown documents to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 3:23 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The documentation standard is ReST and not markdown.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/devicetree/writing-schema.md    | 130 ---------------
>  Documentation/devicetree/writing-schema.rst   | 153 ++++++++++++++++++

I wasn't really ever intending to integrate this into the rest of the
kernel docs, but I'm not tied to any format so:

Acked-by: Rob Herring <robh@kernel.org>

>  ...entication.md => ubifs-authentication.rst} |  70 +++++---
>  3 files changed, 197 insertions(+), 156 deletions(-)
>  delete mode 100644 Documentation/devicetree/writing-schema.md
>  create mode 100644 Documentation/devicetree/writing-schema.rst
>  rename Documentation/filesystems/{ubifs-authentication.md => ubifs-authentication.rst} (95%)

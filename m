Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3215912672C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLSQdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 11:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfLSQdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:33:39 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C03C2467B;
        Thu, 19 Dec 2019 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576773218;
        bh=GJ3ONlmBuk2OXyXl+44rbd5sW+mYWcTLSbl9E+hW9kE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jn8tTwUPyX2erOSQ7Gk3TGOIzNI3f8UW4hkwdNHjXTC7ryhvX7CEXnuRcWcnP5lwv
         KtKMQ31m++B3FJRyI9L+0PmKwIwX3ew/7ZLmofPaGiRGn2rWavnhnstdsTmSClHGDA
         e4h85A5wg7HXpvMoEm+mrmbWYX0lN7/lDdZluTjU=
Received: by mail-qv1-f43.google.com with SMTP id p2so2442827qvo.10;
        Thu, 19 Dec 2019 08:33:38 -0800 (PST)
X-Gm-Message-State: APjAAAUBCvazosCh3aauU8vCAr0QhQK62KmiNyz/sI9hCRlqoNw5dbtT
        HrhBkugvjN+L/Wd+mrQVCE5lbJTaUYz1tl4vUw==
X-Google-Smtp-Source: APXvYqwqbelo2GTHXUib45WhOKB06ajjBg09zd5s+ViYeHQFNDg32R8rATu3WOOkIpYiYC0gXZBJQaUuEaP3Z6sOwLM=
X-Received: by 2002:ad4:4511:: with SMTP id k17mr7960105qvu.135.1576773217716;
 Thu, 19 Dec 2019 08:33:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com> <e717703a746d54fadc35de45ea0bd65710355712.1566975410.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <e717703a746d54fadc35de45ea0bd65710355712.1566975410.git.rahul.tanwar@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Dec 2019 10:33:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLve+1fFkUvXe-L+vWa=uGx8UJUZoifMhLHq=3LggOt3g@mail.gmail.com>
Message-ID: <CAL_JsqLve+1fFkUvXe-L+vWa=uGx8UJUZoifMhLHq=3LggOt3g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: clk: intel: Add bindings document &
 header file for CGU
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        qi-ming.wu@intel.com, yixin zhu <yixin.zhu@linux.intel.com>,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 2:00 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:
>
> Clock generation unit(CGU) is a clock controller IP of Intel's Lightning
> Mountain(LGM) SoC. Add DT bindings include file and document for CGU clock
> controller driver of LGM.

If you want your binding patch reviewed, you must resend it to the DT list.

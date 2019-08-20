Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9495FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 15:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfHTNW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTNW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:22:56 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9D4230F2;
        Tue, 20 Aug 2019 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566307374;
        bh=1rIuBeM0IKRvdxc6b3vVTRd4MHIEw3Zx6tXCfzXBOSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QXM0kFthGloCUwKOn6dugqf5hkxzFjGs8/hVqkmCPXzPSWHg4rqs24kTAZvq0N/iM
         qQ5FfkfHuZ6f8jKZRFce1YCkYOgf/AYFA9AMIxneISXaVEc58bqH6zYfbhTN1SYRZW
         VbjXYYrnTjz/pCEmjFpTzACDhwifbFP6FDDfUYFU=
Received: by mail-qt1-f173.google.com with SMTP id v38so5952492qtb.0;
        Tue, 20 Aug 2019 06:22:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXFxFb4Pa45fvMxwpe1GOoRFhnQ3w1Tm/2JVFpIrAZ/lzA673MV
        H9PimIu12thUsOvfKmaonv0RmsY3kvKGkbBUOA==
X-Google-Smtp-Source: APXvYqwoF+4NBHbc+mh4/cjAOzetDrnx/H6ki3UR8XHIUfmV3E4baxFQHmkTVztJFcWEl8hMkWIGS/6m5JfOpGYIGhc=
X-Received: by 2002:ad4:4050:: with SMTP id r16mr14444599qvp.200.1566307373963;
 Tue, 20 Aug 2019 06:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190819234840.37786-1-john.stultz@linaro.org>
In-Reply-To: <20190819234840.37786-1-john.stultz@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 08:22:41 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+oxy0z283FO8D9FV7xsEX+AsonUx2Feqk8AiDAOmy9=w@mail.gmail.com>
Message-ID: <CAL_Jsq+oxy0z283FO8D9FV7xsEX+AsonUx2Feqk8AiDAOmy9=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] dt-bindings for lima support on HiKey
To:     John Stultz <john.stultz@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Griffin <peter.griffin@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 6:48 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Peter sent a patchset out back in April to enable Lima support
> on HiKey, but there's not been much action on it since since.
>
> I've been carrying the patchset in my tree, and figured I'd send
> out just these three dt-bindings changes just so hopefully they
> can go in and the dependent driver changes can be more easily
> pushed later on.

As it's all binding changes, I've applied them to the DT tree.

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3313A1FA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfEOSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 14:33:59 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36436 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfEOSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:33:59 -0400
Received: by mail-yb1-f193.google.com with SMTP id m10so229841ybk.3;
        Wed, 15 May 2019 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnVd2S8VknS7EmG8FcfjRFAi+NkjPV+gxxEXD/c0pnc=;
        b=U1gPCjG+D+4aIu+PcJQhSCyFUml1ZVD7xRzGJdpN4SepTMBxsIv8dRVFFOe/wL8Vgr
         5Wx9ZjxkBVZaEKQjcbCJcMGrwgPcIgciC/BwNLPWuky2hu3Yq8tf606dj27rAEmmfqoK
         NtIsBGmBp1MBrcLBVBR1Mv2A6CKirC9Xq0ciakxUn1B/9bfKR1YvdYkccFW7JYdlS8ed
         A1HA77zqhEmom1IKc0udacwIeVs+GWbKQt/hXjK5tSQxQ0fQN5pBwcpJjx22NGqV7fzo
         If3LKxKhOq8IVVLykcIxWxtRcfU1ypwg5MH4R3icqEk6jy3yNCofZCgini1ni/L7mAxq
         RarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnVd2S8VknS7EmG8FcfjRFAi+NkjPV+gxxEXD/c0pnc=;
        b=N23qMd3h3+BHzv7tSemtM1fNoEnzrwfr1UM8vewDGLSUZlr+FRkMFEI7MVjYDiyDtC
         C5cGOBlKsO6CzrrwiNEPAhKcOEcRWmMyXLIohsofuUhfQIPjqRHPxVxsjOIvWBsh0h5W
         Vgr73gKvBdzBj2iRN+1qSNZwNJL9CvyBPp9VIudwVKx+ta6aXuZutARHuyrO1XrHtHx+
         1jjO97duEThdRu2m5MMgy2u7QDW2OhjHCB0+eZ0zK55GDN3TghVqLu+stBRTMoBo1wkJ
         upQ3ue+WUWhA6Wf7Z2jbNQHzO2ThYpfawCDK/G8IAZLJHPG9UiofNK15IxJotLRSS+65
         iXSA==
X-Gm-Message-State: APjAAAUZj/5Iqj/dU4UXs83SP6WBwJrWy0hfaVhnAaSGluhRkmLU2jGQ
        EA+C68oYtPUSy0LsLYdPcbJTMotSRX2XXXDxPy0=
X-Google-Smtp-Source: APXvYqyIhd2iPzcP+rbRmFUBJ+m9T5N2f9m167KLV8oGalcuqt6Z8jWcA/wh/Y+HxmjzzMYCIMCeIuYYq0bnwOtP7tM=
X-Received: by 2002:a25:4485:: with SMTP id r127mr19575805yba.386.1557945238502;
 Wed, 15 May 2019 11:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190514170931.56312-1-sboyd@kernel.org>
In-Reply-To: <20190514170931.56312-1-sboyd@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 15 May 2019 11:33:46 -0700
Message-ID: <CAMo8BfL+JSBtw_HmZ3y9AnBK0vhg+YCw+f1E3XOfOaFFFaFQqg@mail.gmail.com>
Subject: Re: [PATCH] clk: Remove io.h from clk-provider.h
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Tero Kristo <t-kristo@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        John Crispin <john@phrozen.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 10:09 AM Stephen Boyd <swboyd@chromium.org> wrote:
> Now that we've gotten rid of clk_readl() we can remove io.h from the
> clk-provider header and push out the io.h include to any code that isn't
> already including the io.h header but using things like readl/writel,
> etc.

For arch/xtensa/platforms/xtfpga/setup.c:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

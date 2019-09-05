Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10505A9AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 08:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfIEGm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 02:42:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41251 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbfIEGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:42:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so238244wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4FxT3sbg905x6neVVBFFY3spRc8+0YKGMTWU5uG6+h0=;
        b=wxlWx/qSbcPpE76utweI7A0cLy9DrjtSsoAqtfV6WPGO6arQeRwLYRCoyb13wSdY2Z
         655GB7phDY6TttcqOOFiP6ROfNmtwlxb0lskXM2I1LkhloZIEInNRhxotvbK4b/ogytV
         u/vcFc8JayRCtriCHPY3JfzCi3kAu7dCHIdpWcCi0NjBCfRdOiZ7AHIpZIdwvB6oUub7
         EipZ/dIakAO1jrc1+WsNumzS94ASiMIhnOLSohIQZd48G5lW93647zNwunwCnRJDPfF0
         dYJ4FK9cLboExNBjwJ4pYgppi671aLGIs6fh59Hu2j0H9RR/dllE7KO3vjx2D2dssxEe
         yrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4FxT3sbg905x6neVVBFFY3spRc8+0YKGMTWU5uG6+h0=;
        b=CmQHnUD2tFLR5msvhY9NkoZLoJ8NCtmEwdUO5F5A+5FajtgILEnDrXCUpGKEBkkH+V
         cZz1oi+w+fytFNYsA2l4Do8mRKE9cuLxnnxF/YWPRAwS9+bQf9ZkihqRRZ7vtLXF4RXs
         76Fvc/psTNB2UmBIA/Jw9BMFPQo0lJTWfQi8hpvWcof+CgaY2CE+gruaHjGzgBFyw13J
         mVkHyirhqy2zcWhHcxXHYeIyImzxn/15y6JbcLbLi1g3bbwZ1Vn5N5VUNpcr0KuM9vip
         7mvM9rtPWnJZuDRqP0Xl8SuEFRytsYjxhETEyUfQUVX/skA4A70MsF0IMq+wQAtetQv4
         h7Pw==
X-Gm-Message-State: APjAAAWRfl9waTfbPyYJ7TsVq0/6zrByijhJHr2CRgBvnBL/yZIVlp0p
        tTABbnLsHNF5d7U6i/mKSn5SNA==
X-Google-Smtp-Source: APXvYqwvRbcTUQl24Kcx5vN7rlGOqv2utPQevH7gWXz+Y2nMcnBafBkxzETNfut6xVZQ0Q8Pr4WMgA==
X-Received: by 2002:adf:e881:: with SMTP id d1mr1133373wrm.301.1567665775928;
        Wed, 04 Sep 2019 23:42:55 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id f66sm2329533wmg.2.2019.09.04.23.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 23:42:54 -0700 (PDT)
Date:   Thu, 5 Sep 2019 07:42:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] soc: qcom: geni: Provide parameter error checking
Message-ID: <20190905064253.GU26880@dell>
References: <20190903135052.13827-1-lee.jones@linaro.org>
 <20190904031922.GC574@tuxbook-pro>
 <20190904084554.GF26880@dell>
 <20190904182732.GE574@tuxbook-pro>
 <5d704c9f.1c69fb81.a1686.0eb3@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d704c9f.1c69fb81.a1686.0eb3@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > But if this is the one whack left to get the thing to boot then I think
> > we should merge it.
> 
> Agreed.

Thanks Stephen.

Unless you guys scream loudly, I'm going to convert these to Acks.

If you scream softly, I can convert the to Reviewed-bys.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

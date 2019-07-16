Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7A6AF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 20:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbfGPS7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 14:59:39 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:46851 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfGPS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:59:39 -0400
Received: by mail-pl1-f177.google.com with SMTP id c2so10556070plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hBJsfG+kxvEykqFUPJPZgqlmTa9miwWtUSC2L+vLfP0=;
        b=rTafQ1i3JELdrOWJ5WSPdSQQwWR9tojAgsl4geqBK2ZdDVwUPVO5YBRRdmHlAMJj8h
         T3cIKg3ivUvNYeW+SQt5fcjPlhM6xsK84xL1NqIhkBoSy2h6a2RNvC4KTsY5ruB+TJPh
         a6fSWDYUwWmjaJI+265DFaBcq14FLWh3XyX7CzhJ8qsiTs4K2qNpwP9B4/CX+HDSNua2
         t+cuf4OmTC6gFXaAnM/QAwdfKPK8ire8G6YjF3jHdzA9TUSIrU3A/AcXiM9voIVS78Hn
         t81Odf6StdnitZCOEhpJsq24DvZVwpJ99em5+JTs748nSoL1O4trtGWXzdZHhmi8nmkl
         NE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hBJsfG+kxvEykqFUPJPZgqlmTa9miwWtUSC2L+vLfP0=;
        b=gMJYKn0ceacw8zw5uABi1fsAP68oNCv/lUT/acjSM3TPrjVd8v29AxwRyhho+zza9Y
         OghOef3WmcWlZI/uVgI7aAM+AG8zNCIf2xVoZ71PUQsJMaazO04RJQEt9maoOrGa4u6K
         c6ovpYdlo4SSyZYF6lzCpvICvpLXRdJhNY8lJkwWKBg6GdOKhcLymhy9mpxSAU8zEx9z
         bbVMElyu0RdDlo+aziPOUchLSn/oG9Ij9hIdSmrQIOw1Ull5Ju7/4hLdSidLau6mzVJu
         1F8xAIJNGiokoirfN6Jcbz1zTdNgX/XTsLC/ZR0D+mbFi4M5TICGT7As2WTbCvcbkrF+
         z+tQ==
X-Gm-Message-State: APjAAAV7xL1uCtCKhV45a4MpRV/g3pT2o04xPwMy7wlvi456btwRnADZ
        30CMYkfEpv5fw2uNzejC6PPKWg==
X-Google-Smtp-Source: APXvYqxJBz67JnnuTcUz76s83oxJjhlbQ27GD9dFu8zmDsc8MA6X4i+IL4StramzuJafjdqHNn3w2Q==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr38000072plb.258.1563303578543;
        Tue, 16 Jul 2019 11:59:38 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i124sm42317997pfe.61.2019.07.16.11.59.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:59:37 -0700 (PDT)
Date:   Tue, 16 Jul 2019 12:00:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pi-Hsun Shih <pihsun@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [GIT PULL] rpmsg updates for v5.3
Message-ID: <20190716190057.GA8572@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rpmsg-v5.3

for you to fetch changes up to 54119bc1110dab2fa389f45c73a0787b8e037e8b:

  rpmsg: core: Make remove handler for rpmsg driver optional. (2019-05-21 23:54:06 -0700)

----------------------------------------------------------------
rpmsg updates for v5.3

This contains a DT binding update and a change to make the remote
function of rpmsg_devices optional.

----------------------------------------------------------------
Pi-Hsun Shih (1):
      rpmsg: core: Make remove handler for rpmsg driver optional.

Sibi Sankar (1):
      dt-bindings: soc: qcom: Add remote-pid binding for GLINK SMEM

 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
 drivers/rpmsg/rpmsg_core.c                                | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24D618C787
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 07:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCTGey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 02:34:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42847 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCTGex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:34:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so5176347ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 23:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EN5kJIjrDw1mgoma/zwe6C2IRFI0DiYfgabsVqUwoBk=;
        b=UFzo6MVBPLDq6LaahJnJhgqy9QcASg2VsWxFtxxJqOCPPcNxMkH2gdkN/rL88RNMWE
         lv3Bun7kMu7e/k8R4ULX7rOUxZaCHBZfBMmyC5QBMxRRwKpGUYzOi4GVdsIG0vfJLjHY
         21lJv4xEP4IehCfnWAe7FW9ICeRSK3cXcvKJIZ+bqM/PpwoRNfTSQLlIxPWHexvEi4w5
         nF5/tTXgUBIAefZNhp2dfsKIWxBiV4BSyKVFtsq0FddxSe+OIlBHdAR3cI88Sx+Gx9Lg
         7WmJ4Qv8TFe5hE1V2FbBR6nGMzqac/qyj/GNq5KsZ3hWOm0DxjKrPUY9029XVfDQTjkV
         nhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EN5kJIjrDw1mgoma/zwe6C2IRFI0DiYfgabsVqUwoBk=;
        b=SlxKD9PZoGt+DLy25BFagD1NL8rwEw8wx/0HeRlqU9DPj5sqWQDjGd+Y4XU1XTeyuk
         PGJ95OW0BY6T8urQRDGnDd8mCZgVi2JGxQN+SzU7fTwhsDudCiemOWq+mSjKPyACZQOU
         FFKovdbbqdNS5i089ldYaVOCEElKE5eH1CZNUS/3Ivw/Wb+iaPbTr2LTiL9PZ09Mg+5j
         PhcIY9VJ7+8FqlrP2YszXcwGxat1FBOwVgnb0IqU9naA1mqwshoH9ViZRYNvlc20+pfR
         dtuSKdaBjIbwBrGHnmqj0SQ4jGoCEknDM3NcqLoVyXR/cio2gXHQyR/gzb49x/h+DiY+
         sJVA==
X-Gm-Message-State: ANhLgQ0rxD+1o4j03zBbyaIMdzUinsF4zoERRz0mr1e4aD+e1aTU6922
        DI1YKLMKtzk84ywh7DDvQuD5mA==
X-Google-Smtp-Source: ADFU+vsBf8yKtP2HvAQixVnArfLXpQKief8SGtO73/OQ886ubDAeeOSQpYCwMKdMyAwsibcXp7pgLA==
X-Received: by 2002:a2e:9897:: with SMTP id b23mr4397938ljj.97.1584686089605;
        Thu, 19 Mar 2020 23:34:49 -0700 (PDT)
Received: from jade (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id f16sm2732885ljj.34.2020.03.19.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 23:34:48 -0700 (PDT)
Date:   Fri, 20 Mar 2020 07:34:46 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org, Rijo Thomas <Rijo-john.Thomas@amd.com>
Subject: [GIT PULL] another amdtee driver fix for v5.6
Message-ID: <20200320063446.GA9892@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this AMDTEE driver fix for an out of bounds read in
find_session()

Thanks,
Jens

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-amdtee-fix2-for-5.6

for you to fetch changes up to 36fa3e50085e3858dd506e4431b9abd1bcb1f542:

  tee: amdtee: out of bounds read in find_session() (2020-03-10 08:12:04 +0100)

----------------------------------------------------------------
tee: amdtee: out of bounds read in find_session()

----------------------------------------------------------------
Dan Carpenter (1):
      tee: amdtee: out of bounds read in find_session()

 drivers/tee/amdtee/core.c | 3 +++
 1 file changed, 3 insertions(+)

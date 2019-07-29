Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37F78398
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 05:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfG2DP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 23:15:26 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:38190 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfG2DPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:15:25 -0400
Received: by mail-ua1-f50.google.com with SMTP id j2so23412334uaq.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 20:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=hv50VkGhnzxnnT8SEB/v6U7ft24ex2xN4B83wsU3pLLCGJ21IBSP44PkqdC1R5RwDj
         +bAPdXlNShqh1o+/pxyjjsWF9KfFRTy+FBu5PQaEJfbxm/yGFF+oNyHAwtEylabaCOv2
         4sehnSK6o6OEnIx6MVCzclDRZTm4nFrEx3mVm6Os/ytFo2/fvYkWX8pqURnZ/DiHfHuU
         WXw2N//T9zecomGEJESB00/dj8ynT1DLIolXrW5KvCfGXM4q/abSKChkGhbLIMxnVNCp
         +BWxbCPSju4sV+bCCiw4a74fENHGrxbrg379fWBF1U9i4TOJiTFEifIf5wnuHjmfwbY+
         OzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=lItzqlr3vDjKqXJxvl+7C3MQ3LH/7bLGT498UHLtD0kgBR0Wdk1H7LmHH3vyLzC7WW
         cKqeAUd/75ZtofUXDzAPyO0YiI2W2oF6PJNEzFF3ZKh2YzThtT1jM7N3Og1ANx7s+EFd
         shZEhqfd4ujqUsJfyyz3orHL8+qpbMrB2qGLRnJhBZEnnw7/l1Amj6HDvH921sz0vVju
         dZmkQ758/BaK6elGzsa0b4mgpGaLxrrqrJfKPcSVmrNnBBJppc2aNV/4qEdvRO6s1mMy
         Z6cgyzcz7Aa9FpAiSr1vwGrxQLnR0NrrZOmATcASICNeo4yVK/r2H1MfGhylVAy2EsnQ
         LjrQ==
X-Gm-Message-State: APjAAAU+Kzde7nsW6ycnrM3/auGLOjZaPYTg7/cqJmcES49fetD53QWH
        JBBEzOqK1hgTyNfrYHK64wEgptdsqhGPebkdvbbaW2qYpr8=
X-Google-Smtp-Source: APXvYqw4xpXV1HwxWIut74Sa4GYo7ZeKeXgoizqDRgry2HM2j//1+boKd91mE3gS0mTlCbKNg6852PfyWiS8MVabUDU=
X-Received: by 2002:ab0:699a:: with SMTP id t26mr42505268uaq.70.1564370124649;
 Sun, 28 Jul 2019 20:15:24 -0700 (PDT)
MIME-Version: 1.0
From:   Lin Xiulei <linxiulei@gmail.com>
Date:   Mon, 29 Jul 2019 11:15:13 +0800
Message-ID: <CALPjY3kYgfKDN8MNvs18K8xJVU9U2=c5K=_t25ZicUosZyzASw@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe linux-kernel

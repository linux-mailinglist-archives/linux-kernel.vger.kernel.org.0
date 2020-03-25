Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BAF192DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgCYQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 12:04:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46149 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgCYQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:04:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id v16so2999417ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pn2KqvNFk/Kh/oN0XHQ6BHDkBBBhQ3u1DOedSWlNkfQ=;
        b=NgTT4k5jlKQgS4xPUfrNeL4uN7tSr+FEjGTa0+opI2N8PJO6UtRhuIb/sfAji0iY5E
         rpYPeEVdAQ+nQvJJF5LweKq2TJ1MRLDae7RaM6LxnVdeeulKZjz1ZsvXv8uVrZ1V3THB
         uSYPP1p5vjzUNLwlKM728XMoTGFMLF7FmKOv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pn2KqvNFk/Kh/oN0XHQ6BHDkBBBhQ3u1DOedSWlNkfQ=;
        b=bz++Yexs342Rnm+rfW2x+VjV8ymf4L2A2hvjW4fbUMyF6v700PM7Y/K0KVWLNxZZfb
         /V+gChLirafpBz6fxYOpKGTQN2RKCKjtaYVQQxWNsYI4JWP9e2AM5acBOhU66cGz++TE
         UMpvv/jKhurrSg6++thNXfHP45+h6gxzbSr8ZYFYCd7n1PlpkbR+ZWuos8QqETsozEOu
         TbqqXPanPHQlvhf6KHntYSjnIjldyxNdcHZi3QXpDsSEy2pANsAApa7Y+GynxpqzgetA
         OorLVZbPa5H24TWquyPliVu+rtbdq3gjnPkyuw2eBfFjm1el2EJBCDlVa5moWnQyUwBe
         emHw==
X-Gm-Message-State: ANhLgQ2yBV+6bqnWTEKx0TYdHuzJcuwPLZT/lvyGxt8/fatzj0kORtfb
        XSk8V8bBKh35i6iSQNSlmqNc8+PfvcY=
X-Google-Smtp-Source: ADFU+vvBYbmvc9V1PKxar7MW3tqD3E9VYzgKkKzbE64R/vmTXARmGNmYEzFXKQpQnS+Gkb0n+LG2Rg==
X-Received: by 2002:a2e:88d9:: with SMTP id a25mr2478316ljk.267.1585152249331;
        Wed, 25 Mar 2020 09:04:09 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id e14sm11924118ljb.97.2020.03.25.09.04.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 09:04:08 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id p10so2830618ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:04:08 -0700 (PDT)
X-Received: by 2002:a2e:9216:: with SMTP id k22mr2471412ljg.278.1585152247655;
 Wed, 25 Mar 2020 09:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <1580822300-4491-1-git-send-email-pillair@codeaurora.org>
 <CAE=gft7EOALEMUWzoR3+pjoxCUTYWbiXoXY=dXH1BDhS3KwBzg@mail.gmail.com> <000901d60295$3acc79b0$b0656d10$@codeaurora.org>
In-Reply-To: <000901d60295$3acc79b0$b0656d10$@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 25 Mar 2020 09:03:31 -0700
X-Gmail-Original-Message-ID: <CAE=gft7zqbUnx+BULDD+35z2p1=545=jF0=n6kFXZgo3ZTdCHQ@mail.gmail.com>
Message-ID: <CAE=gft7zqbUnx+BULDD+35z2p1=545=jF0=n6kFXZgo3ZTdCHQ@mail.gmail.com>
Subject: Re: [PATCH v6] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
To:     pillair@codeaurora.org
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 4:05 AM <pillair@codeaurora.org> wrote:
>
> Hi Evan,
>
> I will send out a v7 for this patchset.
> Since I have to configure the S2 SIDs, it is dependent on below ath10k patchset.
> https://patchwork.kernel.org/project/linux-wireless/list/?series=261367

Ah, right. Thanks for the info, I'll check out that series as well.
-Evan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7991ED1C28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 00:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfJIWsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 18:48:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37099 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbfJIWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:48:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id l51so5602856qtc.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Z+3EdhKE+AeW2xdFzbCTybbKxG5jLxRNaHCmlepKnCw=;
        b=tPiQH17p72YrZtxFr1LqCPf01LguDgjeCPY7Ev5YfqIPrJ/jRhim9woLkOrLDv86X4
         /aTnTOeJ/t7E8+CWY4V1sCiZYSC0UHo+oyNlRfWZdzCIY98M1Nnf4MHw4wkL2zzQW/S/
         zw4SffqEqQHWaJ9Cj9mIgAzY3aMgpsd0+8CQH/3dmVd5Xt3ED0VnDQNuWzgAmkntww3b
         0sLsxRb5azzyG1iR14POYl4Z2x4ImSvxfU85iuQUVs5nD4C6PdRuUJvuYrd1xElpvJGy
         ZESG2CHc7o63RVUq95aRQ1wFXbsJ6UMNw0XEbffHkKP+h5m4racXVPILlsoVpCcNsU0G
         Eu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Z+3EdhKE+AeW2xdFzbCTybbKxG5jLxRNaHCmlepKnCw=;
        b=Qh44QyNrKyhiDhzyi7ViX2IGuD/IoGfUj4NNASb02HlHLy3zTrB6PgWd+QuVDoClbw
         v5Evz0AfnR03v8CR7JYh65ekEv4CojpVgDKqeDqFFn8MoWEl7JO5Vlpmufyk84HrMZrz
         G/Dby0NPFjhVXarTlhE7T+FqxwcOdgyHtUnrQct1Eh8i5hF6WPCB/aVBwA3mLoSMxNar
         jfnSYhBtcQHCMTFS9j23Bh0fBqoDvcORG/t6SDPA3ORX4twAiEEDFAM2A2/6D1F1fxt9
         TVyx1Tck/E0zlE4J+CWZx5oNcJfu+ABrYIoEVgPYkPdYHUDtk6MfDGiSqDB0D0vYuRIK
         K3Cg==
X-Gm-Message-State: APjAAAVGlrZk0ddYyrzVWptzYF2lpR+CG0t+JpK7Oc2ucOBSuRQ2tc6/
        JHndMfhZsjD6Eop5SDECqlI7HQ==
X-Google-Smtp-Source: APXvYqzbI6LUeO5TJ+8XMFJemSA1dYxl8UN4xKPjlcsfjqpVjIN2lEJW3zfkTDGY3/sCKeE6Lff2vw==
X-Received: by 2002:ac8:682:: with SMTP id f2mr6557906qth.149.1570661298493;
        Wed, 09 Oct 2019 15:48:18 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s16sm1414725qkg.40.2019.10.09.15.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 15:48:18 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:48:03 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Miller <davem@davemloft.net>, j.neuschaefer@gmx.net,
        linux-doc@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        snelson@pensando.io, drivers@pensando.io,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: networking: device drivers: Remove stray
 asterisks
Message-ID: <20191009154803.34e21bae@cakuba.netronome.com>
In-Reply-To: <20191003082953.396ebc1a@lwn.net>
References: <20191002150956.16234-1-j.neuschaefer@gmx.net>
        <20191002.172526.1832563406015085740.davem@davemloft.net>
        <20191003082953.396ebc1a@lwn.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019 08:29:53 -0600, Jonathan Corbet wrote:
> On Wed, 02 Oct 2019 17:25:26 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > Jon, how do you want to handle changes like this?  
> 
> In whatever way works best.  Documentation should make our lives easier,
> not get in the way :)
> 
> > I mean, there are unlikely to be conflicts from something like this so it
> > could simply go via the documentation tree.
> > 
> > Acked-by: David S. Miller <davem@davemloft.net>  
> 
> OK, I'll go ahead and apply it, then.

Hi Jon, I think Dave intended a few more patches to go via the doc
tree, in particular:

 docs: networking: devlink-trap: Fix reference to other document
 docs: networking: phy: Improve phrasing

Looks like those went missing. Would you mind taking those, or
would you prefer for them to land in the networking trees?

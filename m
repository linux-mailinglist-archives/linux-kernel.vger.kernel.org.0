Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3F82503
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfHESml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 14:42:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34257 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfHESml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:42:41 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so169496228iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btKztvvTO6mlAl/5kngK8A6Pv27DqvQDJeoRRHiM1gI=;
        b=KzOjtIxMYqfFawpuIEQR2t/dMkYr2K0I2Wt+NIQl3dCDJ3H0GGxmBiYsg/wS9IR6Zp
         RIyPqGsBt2U6oIpu8hWDv1jG9wp/l/PKxgP/0jk2g43o9d5e8nh99bn8h3tf74+XOOre
         s0mAfYMbPbVgv0U3/sFqdXTTDIzcE7PMEsgjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btKztvvTO6mlAl/5kngK8A6Pv27DqvQDJeoRRHiM1gI=;
        b=PPVK89gwc6bTZZDvy+xWyWsSgCJRzCDdEtJUuvImJfrVRIjxgV5ve8G4F/k1E4vOPR
         uvgJoOzcmjGsxJyZ0Xn58PWVQ7jX+zDP3Sq/JQhHFTvCLE0+yU28igOn9n6igEiSJfb4
         WfHaTC5CVd59wy1KFYSFebKxZi0K16GLVPfiZnm4oq7CSn+rmBWCVK7MehiPUM2fG1/8
         MbRBchsfPKnuaHk54cZNcQobPgoGEuuocp81J26bMWmOArT260KOiCCs7/iFsjgz995D
         qOue5hsiD/aF8LPUp/Qu3by8iC1tnueaRxDc5PEq6X36FeO1Z/3+mC+3UND9c/0wsPCk
         SlvA==
X-Gm-Message-State: APjAAAV20clKy8UJiSvGtxOE2U4MnFOvWUZs3C7Vk3tJ4Veo6t+MBu7l
        dzWJMigLFZAHA1ulpz+Z5Xkl5zafsZ6y7tqq7pNl4Q==
X-Google-Smtp-Source: APXvYqykOnXvFt94xjl+xYygEzXljeey+EwTJsBZuKvMJviMj2wPQXQVugasO+OisGpIpJoRTxyRbJMciZCf1ERZIQE=
X-Received: by 2002:a6b:ee12:: with SMTP id i18mr16710383ioh.172.1565030560414;
 Mon, 05 Aug 2019 11:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190805143431.GH6432@sirena.org.uk>
In-Reply-To: <20190805143431.GH6432@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Aug 2019 11:42:29 -0700
Message-ID: <CAADWXX_DXyBx5soZdYMcGtVB-MFhCy0C590ez=OH09eA+c1Kvw@mail.gmail.com>
Subject: Re: [GIT PULL] regulator fixes for v5.3
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,
 these got marked as spam once again, because

   dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

and I think it's because you have

   DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
d=sirena.org.uk;

but then you have

   From: Mark Brown <broonie@kernel.org>

so the DKIM signature is all correct, but it's correct for
sirena.org.uk, not for the sender information..

                Linus

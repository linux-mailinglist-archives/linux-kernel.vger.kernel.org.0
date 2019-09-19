Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E89FB8312
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfISVBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 17:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbfISVBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:01:48 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21FDE21907;
        Thu, 19 Sep 2019 21:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568926908;
        bh=pTzJxKFtHzsFwv08HHiMxyoILkD7Kk17iVtmqY6HnSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QWr+eunpCbYG2cDPgzLFnPHIAtshnYRBoUOvuOgqCGLcnx9nWBayQStf51jNLBqD8
         SyMxCbA3WnsalY/1+4JigVn1QGrF9DXY/3O20X2x72KsgdqlHMf7lux2Sp/ICdHZeh
         pv/wnN+ZpUtCTspoAumsdwWUfhULgWHENIbfwAFM=
Received: by mail-qt1-f170.google.com with SMTP id 3so3638572qta.1;
        Thu, 19 Sep 2019 14:01:48 -0700 (PDT)
X-Gm-Message-State: APjAAAXR3D8yOdVfwqFaQcbcBm+aasIdm0puLzZbjgDFsEGFC9Mpr5q3
        SXyXqiljAVRsZBBolohr2qKM/mVOHWCJjhxMPA==
X-Google-Smtp-Source: APXvYqxHBKF4+0mpQm4YpK6lBbUtMJVpbErIBqD7uo6MWilec40UMJ9sSjFXnGjKC27OI/MaLRWZOCYaL07yRJhb1Ik=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr5555945qtn.110.1568926907326;
 Thu, 19 Sep 2019 14:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <1568875145-2864-1-git-send-email-pragnesh.patel@sifive.com>
In-Reply-To: <1568875145-2864-1-git-send-email-pragnesh.patel@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Sep 2019 16:01:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJktitBsBuQ5Zsfj5xvK+5T8jBXbjJkTtqo+NXnZe56fA@mail.gmail.com>
Message-ID: <CAL_JsqJktitBsBuQ5Zsfj5xvK+5T8jBXbjJkTtqo+NXnZe56fA@mail.gmail.com>
Subject: Re: [PATCH] fixed-regulator: dt-bindings: Fixed building error for
 compatible property
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 1:39 AM Pragnesh Patel
<pragnesh.patel@sifive.com> wrote:
>
> Compatible property is not of type 'string', so remove const:
> from it.
>
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>  Documentation/devicetree/bindings/regulator/fixed-regulator.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

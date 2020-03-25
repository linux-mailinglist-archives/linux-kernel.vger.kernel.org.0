Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D25191ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 03:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYCCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 22:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgCYCCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:02:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026052072E;
        Wed, 25 Mar 2020 02:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585101755;
        bh=/4Y2CssKYi9xodlXlUg1S4lUqbYyppWjNLoY+o8qqLk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FuAYSA70l4Q6DF8LSoxB4xncZtLsL3ZCGdGw1fFav4sfqLUtgRJcXy9vY6Hkgx1kA
         SueD9ErtczzImw9JWxScVCuKAlYuTViv2+1e0Wxkb6gGzW0XzwgMdmZcshW9kUvfqF
         ZE+oEIp6FwDo6tRkJNDEG/2oOGOWPBbR348E7bWk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <491d2928a47f59da3636bc63103a5f63fec72b1a.1584966325.git.mchehab+huawei@kernel.org>
References: <66b8da28bbf0af6d8bd23953936e7feb6a7ed0c2.1584966325.git.mchehab+huawei@kernel.org> <491d2928a47f59da3636bc63103a5f63fec72b1a.1584966325.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: dt: update reference for arm-integrator.txt
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Tue, 24 Mar 2020 19:02:34 -0700
Message-ID: <158510175414.125146.1529336276931312572@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mauro Carvalho Chehab (2020-03-23 05:25:28)
> This file was renamed. Update references accordingly.
>=20
> Fixes: 78c7d8f96b6f ("dt-bindings: clock: Create YAML schema for ICST clo=
cks")
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Applied to clk-next

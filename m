Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9FCB0DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 23:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfJCVLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 17:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfJCVLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:11:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F3A20862;
        Thu,  3 Oct 2019 21:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570137066;
        bh=dyUpOw7ZuvlIUKW2HHKhfviDy02NcuppHvAL5YI/Hhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWhgD0fRvoTMHBbGXvnSE/knvwUi555lLD/S/3Jw/0jr3n1io7JN311kdJKIUmlET
         gigv7c4O/MJwSBXikSwOXCgt8hjQzB+WuUiU1MaaTYoBJa66ZciLfKk1/hlVmshkpn
         5pbL+DrWfgc81+Mo098EavSCmBZc5ECIfam1Aplg=
Date:   Thu, 3 Oct 2019 22:11:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] kdb: Fixes for btc
Message-ID: <20191003211101.blqe464hzxy6r7sk@willie-the-truck>
References: <20190925200220.157670-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925200220.157670-1-dianders@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 01:02:16PM -0700, Douglas Anderson wrote:
> Please enjoy.

This comment made me smile and then I ended up reading all the patches,
so FWIW:

Acked-by: Will Deacon <will@kernel.org>

Will

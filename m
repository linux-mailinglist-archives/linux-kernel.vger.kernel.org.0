Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473C292322
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfHSMLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 08:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfHSMLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:11:08 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4DE20851;
        Mon, 19 Aug 2019 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566216667;
        bh=uzo3+PT5EVYcPd8uhm34xLZt0fwzs+OBW/nrC+NPFBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tynwUM+niAQyk/Fkxbqhw/7v01tjrnUoMn2vZ7II4tKdKiyQv5648vddiJhEmDr9g
         6Omzu5hRsAtdk/M6COKjpBugAZw0eCmrzEjUhOTCxHRrXZiGlfRhiT5W8i9+cXX/T3
         xjtoC6y9BmcS+5RrSa0dQmOJI+kNAt52HI/pvhbk=
Date:   Mon, 19 Aug 2019 14:10:55 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Cory Tusar <cory.tusar@zii.aero>, Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: vf610-zii-cfu1: Add node for switch watchdog
Message-ID: <20190819121054.GE5999@X250>
References: <20190814193536.15088-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814193536.15088-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:35:36PM -0700, Andrey Smirnov wrote:
> Add I2C child node for switch watchdog present on CFU1.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Cory Tusar <cory.tusar@zii.aero>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.

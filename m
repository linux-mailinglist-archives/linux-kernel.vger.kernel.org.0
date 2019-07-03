Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017AA5D076
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGBNXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 09:23:48 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48216 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfGBNXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4vVWFuLsHpIWVPpgwHNuzXCST8lBvsaqqrIguyqY5+I=; b=evOQZPp90942wbrSoURbVGwyAd
        xYvOl9kc49jpgfzfyuo92IfubYXYnX5+Ui904ENWMQnsj8iweMbMbxNHcK/MtnJloI480OunE8PFu
        e2ddWhoT1B2Iwb3swRWDaP1Jv45EHg9E9yt7yF+aJF7XB7dvICs24CQfE1wQoHDj6Orc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hiIl0-0005l5-1e; Tue, 02 Jul 2019 15:23:38 +0200
Date:   Tue, 2 Jul 2019 15:23:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: [PATCH 1/3] add doc and MAINTAINERS for poweroff
Message-ID: <20190702132338.GB20191@lunn.ch>
References: <20190702094045.3652-1-frank-w@public-files.de>
 <20190702094045.3652-2-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702094045.3652-2-frank-w@public-files.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:40:43AM +0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> poweroff for BPI-R2
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> 
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>

Hi Frank

This needs you own Signed-off-by as well. Anybody who touches the
patch, passes it upwards on the submitter/maintainer chain needs to
add there own SOB.

     Andrew


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4216A83D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 15:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgBXOXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 09:23:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59596 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbgBXOXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cNXNSAEN0Xy5flX7/ZyfzPXdX9pTbc0Tk/Xe6mR4YNI=; b=Ram8p8+/16c7aoqlL7OgQl10Fp
        tMoqM+RJo9TfXXgZLdkORzJqSUXNXPpQTHof2ssMnw5ANN1g7x7E2ryLZOoUITgg1O7ATGKB3Jgz8
        QudF0skcE7nQS22VXtu8mbnjGhi7sYmTgzD63q/cH3Qff5Jv9nq2XwRK4QkqZbEYab5k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j6Edi-0008GN-Bs; Mon, 24 Feb 2020 15:23:18 +0100
Date:   Mon, 24 Feb 2020 15:23:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     alex@digriz.org.uk, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: orion5x: ts78xx: Remove unneeded variable ret
Message-ID: <20200224142318.GD31084@lunn.ch>
References: <20200221103141.3633-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221103141.3633-1-vulab@iscas.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 06:31:41PM +0800, Xu Wang wrote:
> Remove unneeded variable ret used to store return value,just return 0.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD2EFF90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfKEOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:22:04 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49834 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbfKEOWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u/OP1j0INm7LEy3jDv8RE1WCfpiFT+lOlsq0q7UGwzo=; b=vPGp4hZClfP9BA3FrlRgaRP9tb
        ERKP7QiG+1uWMk0pwbkXjhAfaMt8za5rGXilbwhN54GL9SPYfox6QvcvFghT+pPQlYewGitfSFwoK
        Z1XpZgiEtY345/du/qnyRqcIinHtF6vKENtwVBDUe9OO4OBPkFcM3msf6Qn/UGN7IdXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iRzic-0002Gz-38; Tue, 05 Nov 2019 15:22:02 +0100
Date:   Tue, 5 Nov 2019 15:22:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect
 STP to CPU
Message-ID: <20191105142202.GC7189@lunn.ch>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int ethsw_port_set_ctrl_if_acl(struct ethsw_port_priv *port_priv)
> +{
> +	const char stp_mac[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00};

I think there is a standard define for that somewhere in include/linux
or maybe include/net.

But thinking about the big picture, i wonder why this is needed, at
least in a minimal implementation. Bit 0 is set in this MAC address,
so it is a L2 multicast frame. By default, all L2 multicast frames
should be delivered to the CPU. So it should work without this.

       Andrew

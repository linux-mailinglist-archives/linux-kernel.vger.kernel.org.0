Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F3182C68
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 10:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgCLJZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 05:25:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:52852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCLJZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:25:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE82FAC6E;
        Thu, 12 Mar 2020 09:25:33 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 3D203E0C79; Thu, 12 Mar 2020 10:25:33 +0100 (CET)
Date:   Thu, 12 Mar 2020 10:25:33 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, kuba@kernel.org,
        jiri@resnulli.us, andrew@lunn.ch, f.fainelli@gmail.com,
        linville@tuxdriver.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/15] ethtool: add ethnl_parse_bitset() helper
Message-ID: <20200312092533.GL8012@unicorn.suse.cz>
References: <cover.1583962006.git.mkubecek@suse.cz>
 <70fe704ddd961de7250e2cb7800369509ed6e1d8.1583962006.git.mkubecek@suse.cz>
 <20200311.224821.1526910923298377538.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311.224821.1526910923298377538.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:48:21PM -0700, David Miller wrote:
> From: Michal Kubecek <mkubecek@suse.cz>
> Date: Wed, 11 Mar 2020 22:40:23 +0100 (CET)
> 
> > +int ethnl_parse_bitset(unsigned long *val, unsigned long *mask,
> > +		       unsigned int nbits, const struct nlattr *attr,
> > +		       ethnl_string_array_t names,
> > +		       struct netlink_ext_ack *extack)
> > +{
>  ...
> > +		if (bit_val)
> > +			set_bit(idx, val);
> > +		if (!no_mask)
> > +			set_bit(idx, mask);
> 
> You can certainly use non-atomic __set_bit() in this context.

Right, thanks.

Michal

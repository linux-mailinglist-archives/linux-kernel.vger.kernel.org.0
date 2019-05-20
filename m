Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44D8240D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfETTFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 15:05:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40921 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfETTFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hr/1iGRppucKUPs7Jd/NpqKBvJMNwEtcN7Vo/hR52/Y=; b=d1TmZCCktRBG0kT3B2zm851Rcq
        Oq8vGbMMGgpwEBZ9ZdSa5IHBD/v5MLv5h9tM6dI1VVWjQlDc5+N8VGv7b95g762H67pv4Xw0v0852
        hrkH2UWVrEPyYE7JTy1tlvY2fDG41ksB4Nyk7ShaeXNwLx6lYORQHCHkvryzT9ximM2M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hSnbJ-0002qk-7O; Mon, 20 May 2019 21:05:33 +0200
Date:   Mon, 20 May 2019 21:05:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Subject: Re: [PATCH v2 3/5] arm64: dts: meson: g12a: add mdio multiplexer
Message-ID: <20190520190533.GF22024@lunn.ch>
References: <20190520131401.11804-1-jbrunet@baylibre.com>
 <20190520131401.11804-4-jbrunet@baylibre.com>
 <CAFBinCA_XE86eqCMpEFc3xMZDH8J7wVQPRj7bFZyqDxQx-w-qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCA_XE86eqCMpEFc3xMZDH8J7wVQPRj7bFZyqDxQx-w-qw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +                               int_mdio: mdio@1 {
> > +                                       reg = <1>;
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +
> > +                                       internal_ephy: ethernet_phy@8 {
> > +                                               compatible = "ethernet-phy-id0180.3301",
> > +                                                            "ethernet-phy-ieee802.3-c22";
> Based on your comment on v1 of this patch [0] the Ethernet PHY ID is
> defined by this "mdio-multiplexer" (write arbitrary value to a
> register then that's the PHY ID which will show up on the bus)
> I'm fine with explicitly listing the ID which the PHY driver binds to
> because I don't know a better way.

Does reading the ID registers give the correct ID, once you have poked
registers in the mdio-multiplexer? If so, you don't need this
compatible string.

If the read is giving the wrong ID, then yes, you do want this. But
then please add a comment in the DT blob. This is very unusual, so
should have some explanation why it is needed.

Thanks
	Andrew

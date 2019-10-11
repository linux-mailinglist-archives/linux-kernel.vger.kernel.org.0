Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D029CD3AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfJKIUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 04:20:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37897 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfJKIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:20:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id y18so1363059wrn.5;
        Fri, 11 Oct 2019 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iY3VbFT46lw+lo2paBwupDTtrpw99cdmsvZfo9TjTQU=;
        b=SmkwSbfvxqDKQwKKDk5EWy2klDAogSzP3rzKKTLnMiF9wnXzUJgSCUH6AGsYpLNWDL
         NrVQTzA7aYIwU9/oHM0YuzVdhp+A0xWxAZ4rWMiX8BEljjJNkqBgZRbVUS1n12s3IDeS
         qDXqQzq0xHDLjUR5wWlgTLQjFg9QHl21UKY+muIzQ97ljNKPnMoqhRGw2CfpOUWAH8b0
         ZINz6BwjakkMasDWtmhP0hLvFSfBxaPLBsT5TkeOyYwXx4kKvyL4NIYXhyVdoO2KRs5V
         3NO4iNVI7saRskIYnZq1n3ucrUNWYSgf2QvLKTJ+kiLmasrP1TcqzDS+64tzJkrrPI9Z
         KVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iY3VbFT46lw+lo2paBwupDTtrpw99cdmsvZfo9TjTQU=;
        b=rvCJiEVXYDq7r2CrXgYCKChlkKxJrcQ1Bfebt1lmfl74zZGEZMmUEqjW1ooG46wzg3
         7D1P+hJH6cs+Pw2VlRjwNQ9iEmjeA/fHX8vWW/at/q262Zjabg/xREWH36e2kt2qrXO+
         WAk1KjfnoPl4I0ArU4+aFlVKK4+QVw/nbbzHfUCIVIiHC2e7yy9Gy5t8K2iWECysBDYr
         hh4UfNbsI2ZsQHmoUAcGsEzmA0FdKESkCe9Gz5IU86hl4G6C1gIq+CLv6zRRP+KW20d4
         dkys7xipRFmZQyt9OtDrOqh8CCORaI86jIv8xF1JZTgUedg8cvLQPM1+xmDUwduwQ6Dx
         Zd/A==
X-Gm-Message-State: APjAAAX6BuTvCBM/5LdXa07Sj29wOYN5TElEN2FAV8nakPB2wFy4ExQF
        QvFQt3TL178+NVtwbyMnhO4=
X-Google-Smtp-Source: APXvYqx4BP+NACn/f0HWVAabhBN703zVanaofrdx1aXskPCoLsynKeocseYiViIe4gyYbkJjTss6aw==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr12614050wro.206.1570782009029;
        Fri, 11 Oct 2019 01:20:09 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id f3sm7531556wrq.53.2019.10.11.01.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 01:20:08 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:20:05 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        will@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 02/11] crypto: Add Allwinner sun8i-ce Crypto Engine
Message-ID: <20191011082005.GA4641@Red>
References: <20191010182328.15826-1-clabbe.montjoie@gmail.com>
 <20191010182328.15826-3-clabbe.montjoie@gmail.com>
 <20191011075705.j5bqw2w6jmcrv5dz@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011075705.j5bqw2w6jmcrv5dz@gilmour>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:57:05AM +0200, Maxime Ripard wrote:
> On Thu, Oct 10, 2019 at 08:23:19PM +0200, Corentin Labbe wrote:
> > +	ce->reset = devm_reset_control_get_optional(&pdev->dev, "bus");
> > +	if (IS_ERR(ce->reset)) {
> > +		if (PTR_ERR(ce->reset) == -EPROBE_DEFER)
> > +			return PTR_ERR(ce->reset);
> > +		dev_err(&pdev->dev, "No reset control found\n");
> > +		return PTR_ERR(ce->reset);
> > +	}
> 
> There's only one reset so you don't need that name.
> 
> And I'm not sure why you're using the optional variant, it's required
> by your binding.
> 


Hello

It will be fixed

Regards

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAA334F81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 20:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFDSDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 14:03:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34987 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfFDSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:03:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so1023532wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AKezlGCwmt1d3hzczC9WJlppBQ4qhCVmsBrDFkqR890=;
        b=NkI65du6dgPYlUGfKiTvliI/9cveQe+ie9pJcBFOdVL8p6/YIz3oBLr5KxZnCgRMKU
         OwoFdDEQojvJIGf4osHY7xDogzIg0kSkWefzm5RBcnZWKPJytqbqU4zg9CFp4hVT3nNi
         13dUnBSpFJn6rWLDu78bhTUrR88/h9p2hByQnse/U6UH7GLZpAlWxBNTMwM52r2KDFEm
         xEf09wcguhzWbjgCQnzD5pKNTotTovd0AbSc+ZsgEn/qKckE92B9tW6vHoz3xfQtAujh
         fCplg0RnVSp9qGVwv/thUT1GpaF7Duekr/ZVd+9+OE6Dk7g6vUUt5VzzM6p9Yt5Wkkfd
         gzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AKezlGCwmt1d3hzczC9WJlppBQ4qhCVmsBrDFkqR890=;
        b=Ch8mCy46ecmnmuFDxDfawCiYt9qofM5ppKpNmM2od/Wr1vp71VNbwLPV7dRYc0VqbS
         qmbhUhXmQ67myv6vCmBo2LJQqQpH6Eb4v0WYxlaMyQmRgTFPq5OYacj7e156Cb9wqYcU
         Ad+LrnCfr2ecRPw5QxyVo6p2udOwJlZz1G1Vz+uOl6pxBOna62fwlczY/KwjEcV0TpxI
         KCW+8qr8UtOBYgDnmbJeQM3Wg4CiLFmE0AP0B8hIIIWeMK/ucGVU59Ki13b1GAefBeYq
         MDOEFs5RH6hl2sLuX0MulMqbvwKGDU2kYbsgY8SDf7ZIo4enACn0VE7BnZfneSAFN6hn
         AYRA==
X-Gm-Message-State: APjAAAW5t7y/WaHHPK450v/7T9VFbuVt+pqFJ3rhBIZ5ApoGewZi6kVb
        1n6fs/mwU5jyqnBJkSMTOfhZoQ==
X-Google-Smtp-Source: APXvYqwgO5oh0jFt5NCgY65XpsLvBToWru3FwCZv8E8y/O/38HAfWD8mTN6olAavBZqxQ6s//jnkQg==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr19721376wma.145.1559671413704;
        Tue, 04 Jun 2019 11:03:33 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g5sm21786787wrp.29.2019.06.04.11.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 11:03:33 -0700 (PDT)
Date:   Tue, 4 Jun 2019 19:03:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: common: cros_ec_sensors: support protocol v3
 message
Message-ID: <20190604180331.GE4797@dell>
References: <9d5dbba798410321177efa5d8a562105ff8cf429.1558533743.git.fabien.lahoudere@collabora.com>
 <20190603125509.GV4797@dell>
 <075093e4a45556569f5ecde7f5489fe02df57946.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <075093e4a45556569f5ecde7f5489fe02df57946.camel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jun 2019, Fabien Lahoudere wrote:

> Le lundi 03 juin 2019 à 13:55 +0100, Lee Jones a écrit :
> > On Wed, 22 May 2019, Fabien Lahoudere wrote:
> > 
> > > Version 3 of the EC protocol provides min and max frequencies and
> > > fifo
> > > size for EC sensors.
> > > 
> > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > ---
> > >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 98
> > > ++++++++++++++++++-
> > >  .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++
> > >  include/linux/mfd/cros_ec_commands.h          | 21 ++++
> > 
> > Please note that we are about to add a pretty bit update for this
> > file.  Once it's complete you may wish to rebase in order to avoid
> > any possible merge conflicts.
> > 
> 
> Thanks Lee. Indeed I see and reviewed this 30 patches series.
> I am waiting they are applied to rebase ans submit v3.

They are applied.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8DBA9BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 09:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfIEHZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 03:25:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41515 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730716AbfIEHZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:25:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id j4so1088189lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WzKYcu+ow4nlDzAihnpp11IJFNrWpQ7yO1/2sHTAIpM=;
        b=s2NQt0KGf6ScfAiyv7ZCAWNo6sNvfaH1boh/0UT7xszvjG+R1sL5opPVaFJDDL0TaO
         l8BQu0AI+z1sGJlLrKeFITvJ78/AL29+5uM8AWqkogJb5cWJT5wa3nrMZVA6cgitG3Et
         aOh76KK62i4+0niYPJMjckc/dzcV6di5yXU3tqCN/4WkIB6ag3O9ridR/3t5C63rGzU6
         wE31N1uTbwMcUQVfdKivyEb7xKx5viuaX2r/Ttzyl7EbiPMu648hV/9vJDEAAZLB1zUk
         PHePz2PLd2Y0cvZPVG8jEImGKp7q/6xP/Nghnkr2aA3RlF1fsvGCSO3TmOHxBoQzQFJM
         1RyQ==
X-Gm-Message-State: APjAAAV7gMC03F40rhSumxzgowxzfd92l5vObf7RwqbsdUL4IxO7C5bN
        BNSfxr7/XYyvkUCW/8TZp50=
X-Google-Smtp-Source: APXvYqwe3GqiNgKMNJMqteE0llK6NR+GrtVeJQE+oALj1fVSx0lVXrJ4d8Zq5QmxsfepPIf5nxfz9g==
X-Received: by 2002:a19:2207:: with SMTP id i7mr1308567lfi.185.1567668334824;
        Thu, 05 Sep 2019 00:25:34 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id s21sm212789ljj.22.2019.09.05.00.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 00:25:34 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1i5m92-0007mx-SQ; Thu, 05 Sep 2019 09:25:28 +0200
Date:   Thu, 5 Sep 2019 09:25:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pedro Chinen <ph.u.chinen@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: greybus: loopback_test: remove multiple blank
 lines
Message-ID: <20190905072528.GE1701@localhost>
References: <20190904210547.5288-1-ph.u.chinen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904210547.5288-1-ph.u.chinen@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:05:47PM +0000, Pedro Chinen wrote:
> Fix following checkpath warnings in multiple lines:
> CHECK: Please don't use multiple blank lines

Checkpatch reports five instances of this CHECK, please fix them all in
one go.

> Signed-off-by: Pedro Chinen <ph.u.chinen@gmail.com>
> ---
>  drivers/staging/greybus/tools/loopback_test.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
> index ba6f905f26fa..1e78c148d7cb 100644
> --- a/drivers/staging/greybus/tools/loopback_test.c
> +++ b/drivers/staging/greybus/tools/loopback_test.c
> @@ -779,7 +779,6 @@ static void prepare_devices(struct loopback_test *t)
>  		if (t->stop_all || device_enabled(t, i))
>  			write_sysfs_val(t->devices[i].sysfs_entry, "type", 0);
>  
> -
>  	for (i = 0; i < t->device_count; i++) {
>  		if (!device_enabled(t, i))
>  			continue;
> @@ -850,7 +849,6 @@ void loopback_run(struct loopback_test *t)
>  	if (ret)
>  		goto err;
>  
> -
>  	get_results(t);
>  
>  	log_results(t);
> @@ -882,7 +880,6 @@ static int sanity_check(struct loopback_test *t)
>  
>  	}
>  
> -
>  	return 0;
>  }

Johan

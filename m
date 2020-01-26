Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0463B149A51
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 12:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgAZLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 06:04:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34356 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgAZLEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 06:04:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so4226362lfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 03:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBEvHipDhASp6SrgrMvSSIKcdMGAZhryboaA8IMUX2s=;
        b=iftzFnmxssGft7AeIUJwCpLPyoe3xJpPeQkE8sXKfTMHLD9Dj3NyKuyhbFsFNA3ewC
         w97rDRZzlqLvtoIYGnTSABHlbmp4xnc/QeJFpat736o692vuyVWyY5COL44kI6jpbg5T
         uwniADIqzjPLE36Rna5bFp3jzaSFMDktix760dzPAXP4lc2wnjxMO7VD6Q8BQNBLah4H
         dMXUisrHyS/52oAZYj5E26i2dQEq3AYZ0NAnCRXPoZ37HMRQwiWRc0H9qjR9pRADaWBI
         jYn6P5AtcZMNvdJrI0gXKn7tFFDewxwzHmqYYnvA4/NaKnL6uHw5w95gKcCXd96FvM9S
         BNrg==
X-Gm-Message-State: APjAAAVe47mH/Vo/7Eq/ebZKf8SieYWubxEZvBpX6vcDsKYvI3cyElnA
        5cHxP3uF+ZNzhPFKCrzs3Hw=
X-Google-Smtp-Source: APXvYqxUJWPIUdQ6aj4sUa6PfEhjDgxHlfrOt9/+bFdx0TGpwI3cBGPA3OkKviqn+eYt1PKhd4GFIw==
X-Received: by 2002:a19:cb95:: with SMTP id b143mr1425364lfg.158.1580036679872;
        Sun, 26 Jan 2020 03:04:39 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id s15sm812959ljs.58.2020.01.26.03.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 03:04:38 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ivfiZ-0002mK-R5; Sun, 26 Jan 2020 12:04:39 +0100
Date:   Sun, 26 Jan 2020 12:04:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: greybus: fix fw is NULL but dereferenced.
Message-ID: <20200126110439.GL8375@localhost>
References: <20200126083130.GA17725@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126083130.GA17725@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 02:01:30PM +0530, Saurav Girepunje wrote:
> Fix the warning reported by cocci check.
> 
> Changes:
> 
> In queue_work fw dereference before it actually get assigned.
> move queue_work before gb_bootrom_set_timeout.

Nope. As I said yesterday, you need to verify the output of any static
checkers you use.

The code may be unnecessarily subtle, but there's no way fw can be
dereferenced before being initialised currently.

> -queue_work:
>   	/* Refresh timeout */
>   	if (!ret && (offset + size == fw->size))

Specifically, the second operand is never evaluated if ret is non-zero.

>   		next_request = NEXT_REQ_READY_TO_BOOT;
> -	else
> -		next_request = NEXT_REQ_GET_FIRMWARE;
>   
> +queue_work:
>   	gb_bootrom_set_timeout(bootrom, next_request, NEXT_REQ_TIMEOUT_MS);
>   
>   	return ret;

Johan

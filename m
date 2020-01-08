Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C4713464A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgAHPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:33:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35969 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:33:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so1762439pgc.3;
        Wed, 08 Jan 2020 07:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WyXcOmA2FR+YTuPVbgmSbQ9Ctc12k9J6QS5aQgtYwtE=;
        b=uvDZS20iYP9KaAuiFu/nD1/lqQcz+NX7dyzPpQtjZTEUU3LKFPr7xiMGlGPnx4wJPj
         wMWJmrKO97qI4/AwAYPJs4JL6R8fdKkzXzqxH9l9j3jnezLSMIkAWA3lnZVmXqB0JSi2
         a5wxfZBhryyydDnrIxrcTjeN2N2pkJB02RtnzQ4ARckn9h5krfihSMI++qT8/r6r26pg
         6B3dDtmv3nx+VJt4WwMw20upGWfEmggkHnAy9Z0waOFlA1xLesBL4cm8AGurGCMzdVF6
         VhbwAv25S7IclxSsIBLgkOYJdDxY4aWMyn5kDhfZzCpqeIjY1GUCRzG/eIajVf+fvANO
         88qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WyXcOmA2FR+YTuPVbgmSbQ9Ctc12k9J6QS5aQgtYwtE=;
        b=tAGOHMUZBFdkSq1Vf/IjHtwguX2i1ELS+YMVTv/b2YnoXh+Gr0nWSa7P/ywB0vzPYR
         iOi1T9gZo+gloZxKS2hjmDPFszBuwbhRAzbG9RC9UmwAaRGhoQQZTVjKV+6h8GLoX4z3
         gI8lOEGJDfyUwb8TTbYammrXYOo5flUoEzWKPRO8/s3Kso/oupzlWpjJVm12+f18NW0G
         J9ZAPtD7DRz3sRvX4a4bLvg4m3H+41u4YjIKqT85Jeqn/h5Kvf9z2HKIGg4Nd3qYnk2w
         OftK9t385ZlVhMzq//Vi4lk706P6VzirDviP/zkre7QivdW5/MuvTG9nz0zLQ/51eDqF
         36sQ==
X-Gm-Message-State: APjAAAXvcXlYSq1QOCOQ7SwKIz3JvI0pTpgK3qFT2hufduv+u6LeYrwK
        5Y0WQatZ2GHhQJxCd69R0bA=
X-Google-Smtp-Source: APXvYqx4XxyCgoLUaNAdjTVwAPJUHnFqyiZqjcKi9caXl89EU9VXSYOwIKBb/pA8A2pwI5J8f0xnGw==
X-Received: by 2002:a63:4e06:: with SMTP id c6mr5707782pgb.187.1578497622803;
        Wed, 08 Jan 2020 07:33:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v4sm4440445pgo.63.2020.01.08.07.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 07:33:42 -0800 (PST)
Date:   Wed, 8 Jan 2020 07:33:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] hwmon: Driver for temperature sensors on SATA drives
Message-ID: <20200108153341.GB28530@roeck-us.net>
References: <20191215174509.1847-1-linux@roeck-us.net>
 <20191215174509.1847-2-linux@roeck-us.net>
 <yq1r211dvck.fsf@oracle.com>
 <b22a519c-8f26-e731-345f-9deca1b2150e@roeck-us.net>
 <yq1sgkq21ll.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1sgkq21ll.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 08:12:06PM -0500, Martin K. Petersen wrote:
> 
> Guenter,
> 
> > Any idea how I might be able to reproduce this ? So far I have been
> > unsuccessful.
> >
> > Building drivetemp into the kernel, with ahci and everything SCSI
> > built as module, doesn't trigger the crash for me. This is with the
> > drivetemp patch (v3) as well as commit d188b0675b ("scsi: core: Add
> > sysfs attributes for VPD pages 0h and 89h") applied on top of v5.4.7.
> 
> This is with 5.5-rc1. I'll try another kernel.
> 
> My repro is:
> 
> # modprobe drivetemp
> # modprobe <any SCSI driver, including ahci>
> 
No luck on my side. Can you provide a traceback ? Maybe we can use it
to find out what is happening.

Thanks,
Guenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121D9F27DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 08:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfKGHEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 02:04:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52009 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfKGHEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:04:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id q70so1223804wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1BWOBnBh3RsSrHmTF9OyTNjqu4CElUB2toH/DiA/qIc=;
        b=BED9/AYxEqSzI3EIPyUatgXBzDzJIxvgb0tT/vCP+uqowsV2RHUg0bX6M8PTiGO66K
         n7MyBQhs7dvtPaFHFKpel/rUchRTLdALNm7Nou59bT7p1fZ0MQGt+lJi3gBhtLgJe2nI
         K2ljk6GK9pXXI9DWK67jD+Edy51V3hkVEHkATxqkphL1L5B/RUdDw8UV9MN6cnC+feiQ
         X1yVn1O0lJ2Qqr7nY1RV8g5jxqtwrGcS1eGKEWk337YlszC44W+AkYRuFLEBO4SJJuv7
         ORRsE2UglZFYFgEQC2tCWXH7/lTb3I9PXK50YxjTCVoF749iSKlHRdTYyRllwY0Nix7R
         cVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1BWOBnBh3RsSrHmTF9OyTNjqu4CElUB2toH/DiA/qIc=;
        b=auJCnQMosLa0jAf9dgVm9QXnFWDIN3TXfgpjo38Zx+MyRmG56G/qQHi2u80hTVKDTz
         +pnerB5lxJYVsjJ2XMyHZAScDNJUMVYY+yvHo78Vm5eNtioIPect7txiDxE7m/Uhiovx
         NR2YVm8hJ/GS9l9VOy6PzXdIRg++6j6jl4ImhHV7Vl2+E2sT1rpmAHi0EIkD91iuJgnQ
         TGtSf/AxuKp5ZrScOAYeOJvT20arLnizsZgW2t+GodJZBwGxKMlR7mnsSzx/xFH5Isjx
         aZw7b+EJhEWPDJ0HifH3trtFGnyJYJooz+YNtmBtxJtAvV0V+mjG4siG+HvyMi3/ndHl
         grCQ==
X-Gm-Message-State: APjAAAWLKoYDTSQKvMiA6RGigjIOO2+Z40vmR69I4selGN55D0Pg2uNP
        ovaxsas8OznzNKVwi7AnOmO4DA==
X-Google-Smtp-Source: APXvYqw5oCk6xXi6ixLz7jByPs1zY84R0XhXM9pbgD9ZCxKqdl36Geh9BAUevrqz0GAD8gxGpRTXcA==
X-Received: by 2002:a05:600c:254f:: with SMTP id e15mr1260124wma.37.1573110275553;
        Wed, 06 Nov 2019 23:04:35 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id u7sm1508088wre.59.2019.11.06.23.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 23:04:34 -0800 (PST)
Message-ID: <b22c1dd95e6a262cf2667bee3913b412c1436746.camel@unipv.it>
Subject: Re: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
From:   Andrea Vai <andrea.vai@unipv.it>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Nov 2019 08:04:28 +0100
In-Reply-To: <BYAPR04MB5816640CEF40CB52430BBD3AE7790@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <Pine.LNX.4.44L0.1911061044070.1694-100000@iolanthe.rowland.org>
         <BYAPR04MB5816640CEF40CB52430BBD3AE7790@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno mer, 06/11/2019 alle 22.13 +0000, Damien Le Moal ha scritto:
> 
> 
> Please simply try your write tests after doing this:
> 
> echo mq-deadline > /sys/block/<name of your USB
> disk>/queue/scheduler
> 
> And confirm that mq-deadline is selected with:
> 
> cat /sys/block/<name of your USB disk>/queue/scheduler
> [mq-deadline] kyber bfq none

ok, which kernel should I test with this: the fresh git cloned, or the
one just patched with Alan's patch, or doesn't matter which one?

Thanks, and bye,
Andrea


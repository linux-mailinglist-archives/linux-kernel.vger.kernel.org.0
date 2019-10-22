Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698B4E0C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfJVTEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 15:04:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44281 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732615AbfJVTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:04:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so17297600qkk.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RnIjMRHJMSPKbNY9niWQYtD0BFK9lkZCoZ5skYCypAo=;
        b=Cyx6nT07Vi4tJSjjzdr8xysU2m5BGHzg8F/i+q4NPjayLrf8GvyZxIrLl8teotBRhu
         qvCQX6nFhAosqiorzJ13fJvKfHoiSg3qRgJXKJmcoKWFAvjhaB5yb1lmcBvqGSHJRyEs
         7ZG85Fnh7O+aJ2VydmTeDC6Etb1I0K9mjuNlgEyZxiTdFbUTmlYSH4547SQx7aZJJ6II
         JNbhQLWx7YmccOqInrc7GAfWJMdhCcZ1oTwORxBWh+KWr/s5ofyvmc6yAiseiWosREH2
         +xNmXeOBaNAvsSqul4aioVzTYxlr3BGbcv4IXQ/93r5/iDKdNBvwFticrA7SI0O3WJlo
         1cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RnIjMRHJMSPKbNY9niWQYtD0BFK9lkZCoZ5skYCypAo=;
        b=BuEXSSjSZsz9Kr0vY8XXeoEYFjja77BZibSi9vpRP7m5mEa2ESYRa/Uueb5+VhJb/i
         DiwRqrfMb2StrJUkx70u1t3KnSipEFNVC6OfX8NKfMMNWXO/sFnCdl7dvd08m8SJysnB
         RVLsRlJ6TN/qcnF9+3S4yH++0uNnx5uCyi6hZ/IYygtXLl4i2pV2gY5JNTVBcWIvlP85
         9O2q8chEktrrpy6AQvYAquUH6YrXAMK7TVmtam0ETY62b9N/7D1KJCOfMTJUTX7YPp9k
         bFvB7XOTkg6R+mkrFDkyvVi2v4x8J5hP2goR3RY8FuJB2R0zSouTrjMXEsVO54Ssr1Tq
         Bb8w==
X-Gm-Message-State: APjAAAVpIAbgC898hlG+8jfeMniyngOHf49mgdwKXPPf5uKsYoEeQuHB
        WzNUk402Fm5e8s3f/1x2phPeSvdqhqw=
X-Google-Smtp-Source: APXvYqzSlTX6xHqUfo5bYRRigWYkT+HGShHr3AHboMVNtRnbmnZIXOHLWYpk2QjLc5PdWsg9Zi6JKQ==
X-Received: by 2002:a05:620a:140c:: with SMTP id d12mr4494690qkj.419.1571771059522;
        Tue, 22 Oct 2019 12:04:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t17sm16737280qtt.57.2019.10.22.12.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:04:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzS6-0002er-Eu; Tue, 22 Oct 2019 16:04:18 -0300
Date:   Tue, 22 Oct 2019 16:04:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] Replace tasklets with workqueues
Message-ID: <20191022190418.GC23952@ziepe.ca>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-11-mplaneta@os.inf.tu-dresden.de>
 <20190722153205.GG7607@ziepe.ca>
 <21a4daf9-c77e-ec80-9da0-78ab512d248d@os.inf.tu-dresden.de>
 <20190725185006.GD7467@ziepe.ca>
 <385139f2-0d31-1148-95c0-a6e6768ab413@os.inf.tu-dresden.de>
 <995754de-5ec4-0a62-991e-2ea77a6bc622@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995754de-5ec4-0a62-991e-2ea77a6bc622@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:41:50PM +0200, Maksym Planeta wrote:
> Hi,
> 
> this is a kind reminder regarding the patchset. I added description of races
> in the original email.

Your patch isn't on patchworks any more, you will need to send a v2
with the updated commit descriptions

Jason

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A787961E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfHTOFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:05:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36499 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTOFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:05:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so2781811wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jReI7bMAUtHifdt4nD5J2H5UTJtxX2lBKW/AsAbfjjs=;
        b=JfU99bcWurGHXTYjS250aRYU0WajjW2Qv2mLqo+HjFtSgNG2lsTosMfKgFNE01KIgj
         nYXfRjy3RmWsyvGFfNm9VzafRdp+JN6Ki1zHcg1YC461KeEa3uQguhLBRdoLcEP83XUp
         TgZaPx9VLK40itU5Xa6LwVq1zRgOCW04iVOB7/wnmLxVV50xPwjJ1/oVHPs8yP6Bgr47
         qT+pTbHIthlg9VmWejF2ldbrrU2VpfTT56UggB2gPyo06cCJ5IxTpF5yarIIMX5mo85g
         nMSWgXfb6oew5GZpsXy41KDEWLK9a20QcZzQRJKlvf/dcrgpotz4zhSf29qyAQ7JL5Sh
         hN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jReI7bMAUtHifdt4nD5J2H5UTJtxX2lBKW/AsAbfjjs=;
        b=gjqo48iDMVRBmGFGOJCDImHA8CMurcve9nDchnaXv57zm7PoKRNyw98lpqVkjfMCqh
         4qaYuWsT8vd2uOOQYWEa91fsQ2oJryoZDrZn4cbP/0VxFwgPxGpS+Vliip8GD4DNQQJ7
         TDZVaWbOZ8JEyA4G3tvFF6YkxuXhrwDhqJlJUUhbygKODwJ6sw06RlGupUkZm8NqtrGP
         ATh6LYT4RiA8Bsk7U4xI17d3nEGrBe2XvaUMbmCP+jmXLwmP7Q92aBwy0wub/l5Dx1HE
         ZsQa98GKJIPD52OGBfTbaGlxjhtSJbIWu3KmbIv/vowZaSZeDXBW/Sy0HpdLuoBh81ec
         aG4A==
X-Gm-Message-State: APjAAAW3fugupB7ewmCE9HTJ6ntNeCGjz1tzZ9lcNJz0xzvQMDfyvgyv
        27IMpP+ITJ7EFuaqSflSCeS9PX9vpzY=
X-Google-Smtp-Source: APXvYqw4MIGsbUy36dmztnAjGscnnNmp3vIcsiy9VzU8bwHXFenud56XX0ytvrJ/At3TXy2AJeYO3A==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr204520wmj.58.1566309912730;
        Tue, 20 Aug 2019 07:05:12 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a19sm58665976wra.2.2019.08.20.07.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 07:05:11 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:05:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sebastian Duda <sebastian.duda@fau.de>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: Re: Status of Subsystems
Message-ID: <20190820140511.t5psk5ndnxvyuxh3@pali>
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
 <20190820131422.2navbg22etf7krxn@pali>
 <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 August 2019 15:56:24 Sebastian Duda wrote:
> On 20.08.19 15:14, Pali Rohár wrote:
> > On Tuesday 20 August 2019 15:05:51 Sebastian Duda wrote:
> > > Hello Pali,
> > > 
> > > in my master thesis, I'm using the association of subsystems to
> > > maintainers/reviewers and its status given in the MAINTAINERS file.
> > > During the research I noticed that there are several subsystems without a
> > > status in the maintainers file. One of them is the subsystem `ALPS PS/2
> > > TOUCHPAD DRIVER` where you're mentioned as reviewer.
> > > 
> > > Is it intended not to mention a status for your subsystems?
> > > What is the current status of these systems?
> > > 
> > > Kind regards
> > > Sebastian Duda
> > 
> > Hi Sebastian! ALPS PS/2 is a driver for ALPS touchpad. They can be
> > found on more laptops. And ALPS PS/2 itself is not separate subsystem.
> > It is just driver which is part of kernel input subsystem with mailing
> > list linux-input@vger.kernel.org.
> > 
> Hi Pali,
> 
> so the status of the files is inherited from the subsystem `INPUT MULTITOUCH
> (MT) PROTOCOL`?
> 
> Is it the same with the subsystem `NOKIA N900 POWER SUPPLY DRIVERS`
> (respectively `POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS`)?
> 
> Kind regards
> Sebastian Duda

Hi Sebastian, by status you mean if driver are maintained or orphaned?
I think that definition of it applies from subsystem itself too. But
maintainers of correspondent subsystem would tell you definite answer if
they want to maintain these drivers or not. I should be there marked as
reviewer and I'm reviewing patches for these drivers if I see them in my
mailbox.

-- 
Pali Rohár
pali.rohar@gmail.com

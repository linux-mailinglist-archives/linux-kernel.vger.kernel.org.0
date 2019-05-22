Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B445C26BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 21:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbfEVTaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 15:30:18 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:32931 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733185AbfEVTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:30:15 -0400
Received: by mail-qt1-f175.google.com with SMTP id m32so3870465qtf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XXMtmfD06zcDwQx0hvcfJIux8aKRhVdW16i73453GEM=;
        b=ELELxw7VjTwqNjvY99Fi8KemSTL6yTDX2IVCt6P/+ATzrcEsJyK42hxgn/Y+ckigru
         YH0ydn+bot1cCzh3kqvCecM44RyL0cYkncX7YuaaRgiecpU2HvzBMZV9vmVs4nhXIaCx
         8qqPRtILZRspj5B6KumSwHJH2qV80l395Ws5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XXMtmfD06zcDwQx0hvcfJIux8aKRhVdW16i73453GEM=;
        b=GW3wQhupcWV1Sh1HsbIIp4IaQIfFPHLB0xH3OXhv3HAo55rrwb86J2gghH/QZM5VS2
         arlsA20ruuggWEp50Ijprur0V17DDP7+HdRYMhe5XgYyKk0KpuWY3l+43qJBe8olx/jp
         RDPU9x36U+Hlk4pGPZDeES4YmT7WJoTKWnKaG82C27IE5zFW6eqaT7MMncK6O4WUE2Vs
         Ky31wXxEv3up7ZycCgSfEmOrpappQE9Iv4MHmHcXEE0SglG6cUbECOWkt4zW7DGrWLnk
         AJts5d1YgVJJOA5J9Eb1nP6MTUYLeyjVi4Yj+MseTy8kf4IFN36buNiSIvpVluPXSA/e
         NrRw==
X-Gm-Message-State: APjAAAUmMPSNLj7F7n7QR4z/O1EOyRIn4VA8vULPYCjpDfsg5GxH3ODf
        jX4z0UyIJL3Gn//2ahdX4fV5toi4cCu+Pg==
X-Google-Smtp-Source: APXvYqy0LcxyTKzrA7fqyviU2+zlg0lfX+n6mqhBPOkMDXwp7Mr7KYwA7k/OZixZxbRYh6T9e2XKqg==
X-Received: by 2002:a0c:d909:: with SMTP id p9mr60283913qvj.42.1558553413979;
        Wed, 22 May 2019 12:30:13 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id j29sm11466999qki.39.2019.05.22.12.30.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 12:30:13 -0700 (PDT)
Date:   Wed, 22 May 2019 15:30:11 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: PSA: Do not use "Reported-By" without reporter's approval
Message-ID: <20190522193011.GB21412@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all:

It is common courtesy to include this tagline when submitting patches: 

Reported-By: J. Doe <jdoe@example.com>

Please ask the reporter's permission before doing so (even if they'd 
submitted a public bugzilla report or sent a report to the mailing 
list). They need to understand and agree that:

- their name and email address will become a permanent, non-excisable 
  part of the Linux Kernel git history
- their name and email address will be stored on multiple public 
  archival copies of the linux kernel mailing list, collected and 
  managed by different legal entities

With or without GDPR laws, this is something the reporter needs to be 
aware of and they need to be okay with it, as a matter of courtesy.

-K

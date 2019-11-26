Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8438410A503
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 21:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKZUCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 15:02:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36563 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKZUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:02:44 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so9714876pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u14rKrT7Gow4r3xJ5+yGHcKuDYb4mqLZkkuJ6ycM4oc=;
        b=xDShlhvSye5Zjqy2OEBbxnyTI45hBoOOC636NoFBL3dM3CKjYDgcN+K9emJHE6bzPC
         A1PYOfGxjdXnr5qQk5/EhAnGG+SWzcdoDJPIuPe8x/VnqW2gZyvVmX0b8rht8KI3cEwk
         owv6RgZcmOCyjTSvqJxmthQFXCd1iZzB3uK8nMxzaX4EaTnUuFzDKDTGU8pJ9He2n6It
         /BGtlVzkw9roHeq1hpZ+oX8v+qBdR0sYO0jEJT34lzhhgVlnYwzrTU5QKzFamvZvy6jl
         PAM+ORzbKpOji2gBCRQxO7/yZB6NSoD3BYtd90qkst24B/LJFlJNUaAdHcNvHyzNOxhM
         6huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u14rKrT7Gow4r3xJ5+yGHcKuDYb4mqLZkkuJ6ycM4oc=;
        b=G2hsqnO6o/D3B9/BQN9YPos3jsiYGravZ4G9r6BplRkR53qRFIcKM7FuGQPxszVExC
         kA8J1H4uqvyFwTgY6bXrJPs5LQulp+I9iBaVHVXLNGPK9Q3N0m1dWXyecHkXEFSvAQN3
         EckRrCq9c3s/dF3T5zVFPMjCc+0TeT58M9DgFbS+Uctu0O0wgmdw4XR9ekdyztfmyyRq
         sPnei3jQ8S0Jj0CtTVX3U//Nhb9U+GQj+aa39ANj/4VCCeIvNR4YrwlOp471R+AEGxec
         5XCnb8+1JeJT7mk8V6jE9jSwkGKRZ28GXg5Tsfxvj5cK2ucRCDnmodjkcg8lduHWNnYV
         LZtg==
X-Gm-Message-State: APjAAAWpuxfuKCmmnrxIwYpAcgz6GWtevJh3QRcGlKZSYQ6sYuFA66fK
        gszfjisDFnCKk42wMneWAcbZMQ==
X-Google-Smtp-Source: APXvYqy5sX/6Bv3pIcN1ZNgFGddQH9UStznfWcfBQntq1x7+WA9EqR1VQvQOMLUmrsjectVQip60Aw==
X-Received: by 2002:a63:c103:: with SMTP id w3mr226644pgf.275.1574798563184;
        Tue, 26 Nov 2019 12:02:43 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id y4sm13749935pgy.27.2019.11.26.12.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 12:02:42 -0800 (PST)
Subject: Re: [PATCH 1/2] cdrom: respect device capabilities during opening
 action
To:     =?UTF-8?Q?Diego_Elio_Petten=c3=b2?= <flameeyes@flameeyes.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20191119213709.10900-1-flameeyes@flameeyes.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7df6dd1b-7c3c-9178-e391-aac71a10e1b8@kernel.dk>
Date:   Tue, 26 Nov 2019 13:02:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119213709.10900-1-flameeyes@flameeyes.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 2:37 PM, Diego Elio Pettenò wrote:
> Reading the TOC only works if the device can play audio, otherwise
> these commands fail (and possibly bring the device to an unhealthy
> state.)
> 
> Similarly, cdrom_mmc3_profile() should only be called if the device
> supports generic packet commands.

Applied 1-2, thanks.

-- 
Jens Axboe


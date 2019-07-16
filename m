Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBCC6AEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbfGPSpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 14:45:01 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:33043 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGPSpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:45:00 -0400
Received: by mail-qt1-f172.google.com with SMTP id r6so16481952qtt.0;
        Tue, 16 Jul 2019 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5bZd4SqG2qJ0Rk5uOR53+z/e8nJZoVPsaGfu8z4+z5E=;
        b=aeXDSDzNwe8tXHoal4dwOGH8fayp5W7qhJFcd1lrEkkAlbEdEymP2lBkQINQIGZZi+
         LsqYMxjb1GZBAFFWedkTqtSZJwGsJL0zYRuJdcGXVzh/tsrs6/WhyxUvfv+s3yRSjdCz
         TFZSt1hZMESsTxv/QRe23V6nVH+PjPqm97a2Jf1N8mvsK8vYrduOO3xIKjqnnFhIWI4h
         caWoPzhRJLBN0MhG5UtBJYzJbnS399LhwNnpr3PoEn4ZZ6gvtIwq1iTRXawJjSfqej65
         XmFkS2Tz/Omy19ograyIXq+1uFVX4AHIy7xur1QYtdmGWOWM/ymmjKv0vFpRdN9FRaQK
         VPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5bZd4SqG2qJ0Rk5uOR53+z/e8nJZoVPsaGfu8z4+z5E=;
        b=f/M/BHvL/HAW7F9roDam3/wTlrWb6n+CnkeoU68hvljonu2BXD43CoFGFW8q37fFQx
         yoYmcmnjrdX1OSmia52D9pfR55w/5kFUZNZegrzVuanzsXPTlRpDFkfRHsEspTCs+sUF
         zyD1xm5pqfcwKpJGmuSOYW34l1gljm7ktv90OzcQHkkkCTFSEd9WjN9bGkl/TnG0/i1A
         faWmmCbxNM5OKi9E4tI6h4CfZDE93I9fNA8hOya7SanG6sffblrRlc31XHBDGcZLtPkN
         0GmU7MufzJ0kmbKmpaTsrbU5IbOBm9R4gGBHQTP7nhxH+vLI3ExSjREpn/di2kae/odR
         pt6A==
X-Gm-Message-State: APjAAAWasCQCo4bQWD6IfV5usSpbHFbEuF0R1Srg1Xl9mBJQFr82gXnE
        ZlJQtBTcPb7XiYnKFOijRXP5RALw
X-Google-Smtp-Source: APXvYqw8RL2Qgn73RMkNomWBLRJ8mgnHLyqX1ogMkOYuFPoAK9pJJWOJaNVzrivAIPgCuPPzWlm1FA==
X-Received: by 2002:ac8:2e59:: with SMTP id s25mr23880520qta.94.1563302699090;
        Tue, 16 Jul 2019 11:44:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id u71sm10514345qka.21.2019.07.16.11.44.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:44:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 025B040340; Tue, 16 Jul 2019 15:44:53 -0300 (-03)
Date:   Tue, 16 Jul 2019 15:44:53 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Denis Bakhvalov <denis.bakhvalov@intel.com>
Subject: Re: [PATCH 2/3] perf script: Fix off by one in brstackinsn IPC
 computation
Message-ID: <20190716184453.GC3624@kernel.org>
References: <20190711181922.18765-1-andi@firstfloor.org>
 <20190711181922.18765-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711181922.18765-2-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 11, 2019 at 11:19:21AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When we hit the end of a program block, need to count the last instruction
> too for the IPC computation. This caused large errors for small blocks.
> 
> % perf script -b ls / > /dev/null
> 
> Before:

Thanks, applied.

- Arnaldo

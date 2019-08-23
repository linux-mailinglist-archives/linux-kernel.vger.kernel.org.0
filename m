Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4779B481
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 18:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436728AbfHWQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 12:29:47 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46091 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389546AbfHWQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:29:47 -0400
Received: by mail-ot1-f47.google.com with SMTP id z17so9243405otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=F34BcrdxKel8hln0GXTYZG6t0mQg84zx3JyKZCvo2oI=;
        b=aWkXo33Ebepi+pYiFIMQ80GJwL17nl5KNaU/zxEn0z2keFwe+5TnHcfYFh4hB2VXMS
         QhhghW7KJjkaKmrCEYLS/1wuM8pt7FvWZPjs+jXKY7HRt17KLL3JIsLXz8gxCDzLFDq4
         uny8uweS3T+PWC7vt/tNB2CTRPiC5ixRpWyn+pKW4VGVd6bp87OxWQu9l8LivkkXAqiD
         O8T4QdjidyCeiNtgaCUUUfQ/X0wbrWN+XLb4kvEV0XIjm24qsAPW/dnRRxkMWq7XqRu3
         JdFgv0GeSNYJRD2j4kOSdAytjf/k4iHREwsys6KRLMIqfMiyyv+70+2sXYM2fQ9wISil
         g3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=F34BcrdxKel8hln0GXTYZG6t0mQg84zx3JyKZCvo2oI=;
        b=Mfl4YORqDfqF/qzSsdGSehLCuqVm3YRkH9ndtJzZHEYjF+S6P3V5NSM6DbAsGjaa72
         Tn5IqGbNi+neVVYIeibz0QgNuCebmEN+yKY27CH9eP9+xkxH10MJXv5FPWoh0jMeZfYa
         LM1hf7h/nSUAZcoQFVEce7fUcXXfA11K91591goKXM/FkOuxu8TLJlv7jmmoLTlRzdPM
         pNpbfqNRCjH6xVVfAA+7h79HpHJxUWEFuVm0H9o6T+G0F3qtMh9gmjNx27XpPXpgXHbB
         mxEum7nhfeX/HWeNKH8Zex3OdcTMlxsbATve9D4AK9DmHetrPmh4tATptFXin4/nFqda
         YKJA==
X-Gm-Message-State: APjAAAV9tjonoVP8acZNnww9koZRhWs45OaqiXVOeAwfZ/Znvfe/fFnx
        Rhha3BYKfcEPFeqhIEE3sKBaSI8=
X-Google-Smtp-Source: APXvYqw8WNSX+asazAH9Y0NIlL/XX3VApQXVERdMkC9qhVvFwhQzD2tS5JJcf+yRF0RWDsozh1bkFg==
X-Received: by 2002:a9d:66c5:: with SMTP id t5mr5097328otm.255.1566577785798;
        Fri, 23 Aug 2019 09:29:45 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id j19sm1042892otk.46.2019.08.23.09.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 09:29:45 -0700 (PDT)
Received: from minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id F22C2180039;
        Fri, 23 Aug 2019 16:29:44 +0000 (UTC)
Date:   Fri, 23 Aug 2019 11:29:43 -0500
From:   Corey Minyard <minyard@acm.org>
To:     OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Removal of IPMI watchdog features
Message-ID: <20190823162943.GA26680@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am considering moving the IPMI watchdog over to the standard
watchdog framework.  This will require the removal of the feature
that provides a byte of read data when the pretimeout occurs,
since that is not available in the standard framework.

Before I remove this, I thought I would ask: Is anyone using
this feature?  If they are, I'll need to rething what is done.

Thanks,

-corey

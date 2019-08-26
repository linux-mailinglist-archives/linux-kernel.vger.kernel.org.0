Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680FF9D140
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfHZOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 10:02:15 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:33260
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbfHZOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:02:15 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1i2FZS-000nMf-Sb
        for linux-kernel@vger.kernel.org; Mon, 26 Aug 2019 16:02:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?J=c3=b6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: Re: Linux 5.2.10
Date:   Mon, 26 Aug 2019 16:02:00 +0200
Message-ID: <8e4c772e-c0b7-c2d4-9301-67702c003dff@web.de>
References: <20190825144703.6518-1-sashal@kernel.org>
 <qju9bd$47qi$1@blaine.gmane.org> <20190825223537.GB5281@sasha-vm>
 <20190826043328.GB26547@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826043328.GB26547@kroah.com>
Content-Language: de-DE-frami
Cc:     stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For me the command

$ gpg --receive-keys DEA66FF797772CDC

did the key import and I was able to verify the signature via
https://www.kernel.org/category/signatures.html
and then the git tag v5.2.10.

Thank you both very much.

Best regards,
Jörg.

